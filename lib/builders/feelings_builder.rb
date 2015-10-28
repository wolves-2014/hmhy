FeelingsBuilder = Struct.new(:assessment_data) do
  TYPE_AND_RANK = {
    primary:   1,
    secondary: 2,
    tertiary:  3
  }.freeze

  def feelings
    feelings_attributes.map do |attributes|
      Feeling.find_or_create_by(attributes)
    end
  end

  private

  def feelings_attributes
    TYPE_AND_RANK.map { |type, rank| feelings_for_type(type, rank) }.flatten
  end

  def feelings_for_type(type, rank)
    assessment_data[type].map { |feeling| { word: feeling, rank: rank } }
  end
end
