AssessmentBuilder = Struct.new(:assessment_word, :indications) do
  def assessment
    assessment = Assessment.find_or_create_by(word: assessment_word)
    assessment.update!(feelings: feelings)
    assessment
  end

  private

  def feelings
    FeelingsBuilder.new(indications).feelings
  end
end
