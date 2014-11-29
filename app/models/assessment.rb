class Assessment < ActiveRecord::Base
  has_many :indications
  has_many :feelings, through: :indications
  has_many :competencies
  has_many :providers, through: :competencies

  validates :word, uniqueness: true, presence: true

  def self.determine_prevalent(feelings)
    assessments = feelings.map {|feeling| feeling.assessments.to_a}
    assessments = assessments.flatten.uniq
    f_indications = feelings.map {|feeling| feeling.indications.to_a}.flatten.uniq
    a_indications = assessments.map {|assessment| assessment.indications.to_a}.flatten.uniq
    unique_indications = f_indications & a_indications
    correlations = {}
    unique_indications.each do |indication|
      correlation = indication.ranking
      rankings[indication.assessment] ? rankings[indication.assessment] += correlation : rankings[indication.assessment] = correlation
    end
    correlations.sort_by{|k,v| v}.last

    # on feelings, find indications
    # on assessments, find indications
    # compare
    # perhaps count and rank this assessment
    # assessments.reduce(:&)
  end
end
