class Feeling < ActiveRecord::Base
  has_many :indications
  has_many :assessments, through: :indications

  validates :word, uniqueness: true, presence: true

  def self.next_step(rank, assessments)
    feelings = assessments.map{|assessment| assessment.feelings.find_by(ranking: rank)}.uniq
    # binding.pry
    return feelings
  end
end
