class Assessment < ActiveRecord::Base
  has_many :indications
  has_many :feelings, through: :indications
  has_many :competencies
  has_many :providers, through: :competencies

  validates :word, uniqueness: true, presence: true

  def self.determine_prevalent(feelings)
    correlations = Hash.new(0)
    feelings.each do |feeling|
      feeling.assessments.each {|assessment| correlations[assessment] += feeling.rank }
    end
    highest_indicator = correlations.values.max
    correlations.select{|correlations, indicator| indicator == highest_indicator}.keys
  end

  def feelings_by_rank(rank)
    self.feelings.where(rank: rank)
  end
end

