class Indication < ActiveRecord::Base
  belongs_to :feeling
  belongs_to :assessment

  validates :feeling, :assessment, presence: true
  validates :feeling, uniqueness: { scope: :assessment }

  def self.assess(feelings)
    indications = feelings.map {|feeling| feeling.indications.to_a}.flatten.uniq
    correlations = {}
    indications.each do |indication|
      correlations[indication.assessment] ? correlations[indication.assessment] += indication.ranking : correlations[indication.assessment] = indication.ranking
    end

    # return assessment with highest correlation value in an array
    [correlations.sort_by{|assessment, correlation| correlation}.last.first].flatten
  end
end
