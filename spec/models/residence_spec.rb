require 'rails_helper'

describe Residence do
  before do
    @location = Location.create!(zip_code: 90210, lat: 9, lng: 8)
    @joe = Provider.create!(name: "Joe Johnson", profile_url: Faker::Internet.url, phone_number: Faker::PhoneNumber.phone_number)
    @residence = Residence.create!(location: @location, provider: @joe)
  end

  it {should belong_to(:location)}
  it {should belong_to(:provider)}
  it {should validate_uniqueness_of(:provider).scoped_to(:location_id)}
end

