class ProviderSearch
  attr_accessor :assessments, :providers, :feelings, :location, :zip_code
  attr_reader :distance, :insurance_id, :age_group_id, :max_price, :sliding_scale, :highest_rank

  def initialize(feelings, search_arguments = {})
    @feelings = Feeling.find_by_word(feelings)
    @assessments = Assessment.determine_prevalent(@feelings)
    @zip_code = search_arguments[:zip_code] || nil
    @distance = search_arguments[:distance] || nil
    @insurance_id = search_arguments[:insurance_id] || nil
    @age_group_id = search_arguments[:age_group_id] || nil
    @max_price = search_arguments[:max_price] || nil
    @sliding_scale = search_arguments[:sliding_scale] || nil
  end

  def location_from_zip_code
    @location = Location.find_or_create_by_zip_code(@zip_code)
  end

  def related_feelings
    @highest_rank = @feelings.map(&:rank).max
    @assessments.map{|assessment| assessment.feelings_by_rank(@highest_rank + 1)}.flatten.uniq
  end

  def by_insurance
    @providers.select{|provider| provider.insurance_ids.include?(@insurance_id.to_i)}
  end

  def by_age_group
    @providers.select{|provider| provider.age_group_ids.include?(@age_group_id.to_i)}
  end

  def by_max_price
    @providers.select{|provider| provider.max_price <= @max_price.to_i}
  end

  def by_sliding_scale
    @providers.select(&:sliding_scale?)
  end

  def by_location
    locations = @location.find_within(@distance)
    locations.map{|location| location.providers.to_a}.flatten.uniq
  end

  def by_assessments
    @providers.select{|provider| provider.treatment_for?(@assessments)}
  end

  def results
    @providers = by_location
    @providers = by_insurance if @insurance_id
    @providers = by_max_price if @max_price
    @providers = by_age_group if @age_group_id
    @providers = by_sliding_scale if @sliding_scale == 1
    @providers = by_assessments.first(10)
  end
end
