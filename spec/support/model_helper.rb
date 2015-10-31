# Include helper methods for model specs in this module.
module ModelHelper
  def primary_feeling_words
    %w(bored tired hopeful)
  end

  def secondary_feeling_words
    %w(groomed helpful cheeky)
  end

  def tertiary_feeling_words
    %w(different awesome okay)
  end

  def words_by_rank(unranked_feelings, rank)
    unranked_feelings.map { |f| f.word if f.rank == rank }.compact
  end
end

RSpec.configure do |config|
  config.include ModelHelper, type: :model
end
