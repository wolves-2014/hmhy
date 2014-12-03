class MatchMaker
  attr_reader :assessments, :locations

  def initialize(assessments, locations)
    @assessments = assessments
    @locations = locations
  end

  def providers_by_locations
    #change method name to providers
    locations.map{|location| location.providers.to_a}.flatten.uniq
  end

  def matches
    #providers_for_assessments?
    # a.taken(n) to prevent looping through too many records
    providers_by_locations.select do |provider|
      provider.treatment_for?(assessments)
    end.first(10)
  end
end
