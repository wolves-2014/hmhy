require 'rails_helper'

RSpec.describe FeelingsBuilder, type: :model do
  let(:primary_feeling_words) { %w(bored tired hopeful) }
  let(:secondary_feeling_words) { %w(groomed helpful cheeky) }
  let(:tertiary_feeling_words) { %w(different awesome okay) }
  let(:indications) do
    {
      primary: primary_feeling_words,
      secondary: secondary_feeling_words,
      tertiary: tertiary_feeling_words
    }
  end
  let(:subject) { described_class.new(indications) }

  describe '#feelings' do
    let(:feelings) { subject.feelings }

    it 'returns valid feeling objects for each feeling given' do
      expect(feelings.count).to eq 9
      feelings.each do |feeling|
        expect(feeling).to be_valid
        expect(feeling).to be_a Feeling
      end
    end

    it 'correctly assigns the rank and words' do
      expect(words_by_rank(feelings, 1)).to eq primary_feeling_words
      expect(words_by_rank(feelings, 2)).to eq secondary_feeling_words
      expect(words_by_rank(feelings, 3)).to eq tertiary_feeling_words
    end
  end

  describe '#create' do
    it 'saves the Feeling objects to the database' do
      expect { subject.feelings }.to change { Feeling.count }.from(0).to(9)
    end
  end

  def words_by_rank(unranked_feelings, rank)
    unranked_feelings.map { |feeling| feeling.word if feeling.rank == rank }.compact
  end
end
