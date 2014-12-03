require 'rails_helper'

describe Competency do
  before do
    @jane = Provider.create!(name: "Jane Johnston", profile_url: Faker::Internet.url, phone_number: Faker::PhoneNumber.phone_number)
    @assessment = Assessment.create!(word: "depression")
    @competency = Competency.create!(provider: @jane, assessment: @assessment)
  end

  it {should belong_to(:assessment)}
  it {should belong_to(:provider)}
  it {should validate_presence_of(:assessment)}
  it {should validate_presence_of(:provider)}
  it {should validate_uniqueness_of(:provider).scoped_to(:assessment_id)}
end

