class Feeling < ActiveRecord::Base
  has_many :indications
  has_many :assessments, through: :indications

  validates :word, uniqueness: true, presence: true

  def self.top_level_feelings
    where(rank: 1)
  end

  def self.next_rank(highest_rank, assessment_ids)
  	joins(:indications).where("indications.assessment_id IN (?) and feelings.rank = ?", assessment_ids, highest_rank+1).uniq
  end

  def self.find_by_words(feelings_as_words)
  	where(word: feelings_as_words).includes(:assessments)
  end

end
