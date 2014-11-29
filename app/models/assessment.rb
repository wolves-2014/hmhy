class Assessment < ActiveRecord::Base
  has_many :indications
  has_many :feelings, through: :indications
  has_many :competencies
  has_many :providers, through: :competencies

  validates :word, uniqueness: true, presence: true

  def self.determine_prevalent(feelings)
    correlations = {}
    feelings.each do |feeling|
      correlations[feeling.ranking] = feeling.assessments.to_a
    end
    [correlations.sort_by{|k, v| k}.last.last].flatten
  end
end
