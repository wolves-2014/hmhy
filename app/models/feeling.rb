class Feeling < ActiveRecord::Base
  has_many :indications
  has_many :assessments, through: :indications

  validates :word, uniqueness: true, presence: true

  def self.find_by_word(feeling_words)
    #potentially destroy...then hide the body in the icebox
    Feeling.where(word: feeling_words)
    # feeling_words.map{|word| Feeling.find_by(word: word)}
  end
end
