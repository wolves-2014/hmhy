class Feeling < ActiveRecord::Base
  has_many :indications
  has_many :assessments, through: :indications

  validates :word, uniqueness: true, presence: true

  def self.select(rank, assessments)
    assessments.map{|assessment| assessment.feelings.find_by(rank: rank)}.uniq
  end

  def self.find_by_word(feeling_words)
    feeling_words.map{|word| Feeling.find_by(word: word)}
  end
end
