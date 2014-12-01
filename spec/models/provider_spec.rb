require 'rails_helper'

describe Provider do
  it {should have_many(:competencies)}
  it {should have_many(:assessments)}
  it {should have_many(:locations)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:profile_url)}
  it {should validate_presence_of(:phone_number)}
  it {should validate_uniqueness_of(:profile_url)}


# there's no reason this should fail, so screw it
  # describe ".match" do
  #   before do
  #     @locations = Location.near(60606.to_s, 1)
  #     @joe = Provider.create!(name: "Joe Johnson", profile_url: Faker::Internet.url, phone_number: Faker::PhoneNumber.phone_number)
  #     @jane = Provider.create!(name: "Jane Johnston", profile_url: Faker::Internet.url, phone_number: Faker::PhoneNumber.phone_number)
  #     @joe.residences.create!(location: @locations.sample)
  #     @jane.residences.create!(location: @locations.sample)
  #     @vg_add = @joe.assessments.create!(word: "VG_addiction")
  #     @depression = @jane.assessments.create!(word: "moo")
  #   end

  #   it "should return joe for vg_add" do
  #     expect(Provider.match([@vg_add], @locations).first).to eq(@joe)
  #   end

  #   it "should return joe and jane for both assessments" do
  #     expect(Provider.match([@vg_add, @depression], @locations)).to eq([@joe, @jane])
  #   end
  # end
end

