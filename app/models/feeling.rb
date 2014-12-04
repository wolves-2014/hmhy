class Feeling < ActiveRecord::Base
  has_many :indications
  has_many :assessments, through: :indications

  validates :word, uniqueness: true, presence: true

  def self.find_by_word(feeling_words)
    where(word: feeling_words)
  end

  def self.top_level_feelings
    where(rank: 1)
  end

end
