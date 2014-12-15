class ProviderSearch
  attr_accessor :assessments, :providers, :feelings, :location, :zip_code
  attr_reader :distance, :insurance_id, :age_group_id, :max_price, :sliding_scale, :highest_rank

  def initialize(feelings_as_words, search_arguments = {})
    @feelings_as_words = feelings_as_words
    @zip_code = search_arguments[:zip_code]
    @distance = search_arguments[:distance]
    @insurance_id = search_arguments[:insurance_id]
    @age_group_id = search_arguments[:age_group_id]
    @max_price = search_arguments[:max_price]
    @sliding_scale = search_arguments[:sliding_scale]
  end

  def feelings
    @feelings ||= Feeling.find_by_words(@feelings_as_words)
  end

  def assessments
    @assessments ||= Assessment.determine_prevalent(feelings)
  end

  def location_from_zip_code
    @location ||= Location.find_or_create_by_zip_code(@zip_code)
  end

  def next_ranks_feelings
    @highest_rank = feelings.map(&:rank).max
    assessment_ids = assessments.map(&:id)
    Feeling.next_rank(@highest_rank, assessment_ids)
  end

  def filter_by_insurance(providers)
    providers.select{|provider| provider.insurance_ids.include?(@insurance_id.to_i)}
  end

  def filter_by_age_group(providers)
    providers.select{|provider| provider.age_group_ids.include?(@age_group_id.to_i)}
  end

  def filter_by_max_price(providers)
    providers.select{|provider| provider.max_price <= @max_price.to_i}
  end

  def filter_by_sliding_scale(providers)
    providers.select(&:sliding_scale?)
  end

  def by_location(location)
    locations = location.find_within(@distance)
    Provider.find_for_locations(locations)
  end

  def filter_by_assessments(providers)
    provider_ids = Competency.provider_ids_linked_for_assessments(providers, assessments)
    providers.select{|provider| provider_ids.include?(provider.id)}
  end

  def select_by_distance(providers)
    providers_by_location = {}
    providers.each do |provider|
      providers_by_location[provider] = provider.distance_from(location)
    end
    # include distance in result
    providers_by_location.sort_by{|provider, distance| distance}.map(&:first)
  end

  def results
    providers = by_location(@location)
    providers = filter_by_max_price(providers) if @max_price
    providers = filter_by_age_group(providers) if @age_group_id
    providers = filter_by_sliding_scale(providers) if @sliding_scale == 1
    providers = filter_by_assessments(providers)
    providers = select_by_distance(providers).first(10)
  end
end
