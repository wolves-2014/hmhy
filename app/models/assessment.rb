class Assessment < ActiveRecord::Base
  has_many :indications
  has_many :feelings, through: :indications
  has_many :competencies
  has_many :providers, through: :competencies

  validates :word, uniqueness: true, presence: true

  def self.determine_prevalent(feelings)
    assessments = feelings.map {|feeling| feeling.assessments.to_a}
    # perhaps count and rank this assessment
    assessments.reduce(:&)
  end
end
