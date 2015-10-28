class FeelingsBuilder
  attr_reader :assessment_data
  attr_accessor :feelings_attributes

  TYPE_AND_RANK = {
    primary:   1,
    secondary: 2,
    tertiary:  3
  }.freeze

  def initialize(assessment_data)
    @assessment_data = assessment_data
    @feelings_attributes = []
  end

  def generate_attributes
    TYPE_AND_RANK.each do |type, rank|
      assessment_data[type].each do |feeling|
        feelings_attributes << feeling_attributes(feeling, rank)
      end
    end
  end

  def feelings
    feelings_attributes.map { |attributes| Feeling.new(attributes) }
  end

  private

  def feeling_attributes(feeling, rank)
    {
      word: feeling,
      rank: rank
    }
  end
end
