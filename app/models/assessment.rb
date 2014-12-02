class Assessment < ActiveRecord::Base
  has_many :indications
  has_many :feelings, through: :indications
  has_many :competencies
  has_many :providers, through: :competencies

  validates :word, uniqueness: true, presence: true

  # Add tests for these two methods
  def self.determine_prevalent(feelings)
    correlations = {}
    feelings.each do |feeling|
      feeling.assessments.each do |assessment|
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

  def secondary_feelings
    self.feelings.where(ranking: 2)
  end

  def tertiary_feelings
    self.feelings.where(ranking: 3)
  end
end

