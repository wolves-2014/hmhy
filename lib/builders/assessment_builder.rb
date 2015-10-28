AssessmentBuilder = Struct.new(:assessment_word, :indications) do
  def to_assessment
    find_or_create_assessment.tap do |assessment|
      assessment.update!(feelings: feelings)
    end
  end

  private

  def find_or_create_assessment
    Assessment.find_or_create_by(word: assessment_word.to_s)
  end

  def feelings
    FeelingsBuilder.new(indications).feelings
  end
end
