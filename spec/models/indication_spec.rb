require 'rails_helper'

describe Indication do
  before do
    @feeling = Feeling.create!(word: "blah")
    @assessment = Assessment.create!(word: "depression")
    @indication = Indication.create!(feeling: @feeling, assessment: @assessment)
  end

  it {should belong_to(:feeling)}
  it {should belong_to(:assessment)}
  it {should validate_presence_of(:feeling)}
  it {should validate_presence_of(:assessment)}
  it {should validate_uniqueness_of(:feeling).scoped_to(:assessment_id)}
end

