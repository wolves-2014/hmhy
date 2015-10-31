require 'rails_helper'

RSpec.describe FeelingsBuilder, type: :model do
  let(:indications) do
    {
      primary: primary_feeling_words,
      secondary: secondary_feeling_words,
      tertiary: tertiary_feeling_words
    }
  end

  subject(:feelings_builder) { described_class.new(indications) }

  describe '#feelings' do
    let(:feelings) { subject.feelings }

    it 'returns valid feeling objects for each feeling given' do
      expect(feelings.count).to eq 9
      expect(feelings).to all be_valid
      expect(feelings).to all be_a Feeling
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
end
