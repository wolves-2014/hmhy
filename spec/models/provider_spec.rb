require 'rails_helper'

describe Provider do
  it {should have_many(:competencies)}
  it {should have_many(:assessments)}
  it {should have_many(:residences)}
  it {should have_many(:locations)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:profile_url)}
  it {should validate_presence_of(:phone_number)}
  it {should validate_uniqueness_of(:profile_url)}

  describe ".match" do
    before do
      @joe = Provider.create!(name: "Joe Johnson", profile_url: Faker::Internet.url, phone_number: Faker::PhoneNumber.phone_number)
      @jane = Provider.create!(name: "Jane Johnston", profile_url: Faker::Internet.url, phone_number: Faker::PhoneNumber.phone_number)
      @vg_add = @joe.assessments.create!(word: "VG_addiction")
      @depression = @jane.assessments.create!(word: "depression")
    end

    it "should return joe for vg_add" do
      expect(Provider.match([@vg_add]).first).to eq(@joe)
    end

    it "should return joe and jane for both assessments" do
      expect(Provider.match([@vg_add, @depression])).to eq([@joe, @jane])
    end
  end
end

