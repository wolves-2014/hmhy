class Assessment < ActiveRecord::Base
  has_many :indications
  has_many :feelings, through: :indications
  has_many :competencies
  has_many :providers, through: :competencies

  validates :word, uniqueness: true, presence: true

  def self.determine_prevalent(feelings)
    correlations = Hash[Assessment.all.map{|assessment| [assessment, 0]}]
    feelings.each do |feeling|
      feeling.assessments.each {|assessment| correlations[assessment] += feeling.rank }
    end
    highest_value = correlations.values.max
    correlations.select{|correlations, rank| rank == highest_value}.keys
  end

  def feelings_by_rank
    feelings = self.feelings.where(rank: rank)
  end
end

