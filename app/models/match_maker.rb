class MatchMaker
  attr_reader :assessments, :locations

  def initialize(assessments, locations)
    @assessments = assessments
    @locations = locations
  end

  def providers_by_locations
    locations.map{|location| location.providers.to_a}.flatten.uniq
  end

  def matches
    providers_by_locations.select do |provider|
      provider.treatment_for?(assessments)
    end.first(10)
  end
end
