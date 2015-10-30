require 'rails_helper'

RSpec.describe AssessmentBuilder, type: :model do
  let(:primary_feeling_words) { %w(boo bah baah) }
  let(:secondary_feeling_words) { %w(groomed helpful cheeky) }
  let(:tertiary_feeling_words) { %w(different awesome okay) }

  let(:indications) do
    {
      primary: primary_feeling_words,
      secondary: secondary_feeling_words,
      tertiary: tertiary_feeling_words
    }
  end

  let(:subject) { described_class.new('anxiety', indications) }

  describe '#assessment' do
    let(:assessment) { subject.assessment }

    it 'creates a valid assessment object' do
      expect { assessment }.to change { Assessment.count }.from(0).to(1)
      expect(assessment).to be_valid
      expect(assessment).to be_an Assessment
    end

    it 'creates the associated feelings for the assessment' do
      primary_feelings = assessment.feelings.where(rank: 1)
      secondary_feelings = assessment.feelings.where(rank: 2)
      tertiary_feelings = assessment.feelings.where(rank: 3)
      expect(primary_feelings.pluck(:word)).to eq primary_feeling_words
      expect(secondary_feelings.pluck(:word)).to eq secondary_feeling_words
      expect(tertiary_feelings.pluck(:word)).to eq tertiary_feeling_words
    end
  end
end
