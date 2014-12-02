class Feeling < ActiveRecord::Base
  has_many :indications
  has_many :assessments, through: :indications

  validates :word, uniqueness: true, presence: true
  
  # Beware select is an existing AR class method
  #def self.select(rank, assessments)
  #  assessments.map{|assessment| assessment.feelings.find_by(ranking: rank)}.uniq
  #end
end
