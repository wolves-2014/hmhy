class Assessment < ActiveRecord::Base
  has_many :indications
  has_many :feelings, through: :indications
  has_many :competencies
  has_many :providers, through: :competencies

  validates :word, uniqueness: true, presence: true

  def self.determine_prevalent(feelings)
    correlations = {}
    feelings.each do |feeling|
      feeling.assessments.each do |assessment|
        # correlations[assessment] = feeling.ranking || 0
        if correlations[assessment]
          correlations[assessment] += feeling.ranking
        else
          correlations[assessment] = feeling.ranking
        end
      end
    end
    sort_assessments(correlations)
  end

  def self.sort_assessments(correlations)
    highest_value = correlations.values.max
    correlations.select{|correlations, rank| rank == highest_value}.keys
  end

  def feelings_by_rank
    feelings = self.feelings.where(rank: rank)
  end
end

