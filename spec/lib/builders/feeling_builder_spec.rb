require 'rails_helper'

RSpec.describe FeelingsBuilder, type: :model do
  let(:indications) do
    {
      primary: %w(bored tired hopeful),
      secondary: %w(groomed helpful cheeky),
      tertiary: %w(different awesome okay)
    }
  end
  let(:subject) { described_class.new(indications) }

  describe '#generate_attributes' do
    it 'returns feeling attributes with the associated rank' do
      subject.generate_attributes
      expect(subject.feelings_attributes.count).to eq 9
    end

    it 'returns valid feeling objects' do
      subject.feelings.each do |feeling|
        expect(feeling).to be_valid
        expect(feeling).to be_a Feeling
      end
    end
  end
end
