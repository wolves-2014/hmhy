class Location < ActiveRecord::Base
  DefaultLocation = Struct.new(:latitude, :longitude)

  has_many :providers

  validates :zip_code, uniqueness: true, presence: true

  geocoded_by :zip_code
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude do |location,results|
    geo = results.first
    location.zip_code = geo.postal_code
    location.latitude = geo.latitude
    location.longitude = geo.longitude
  end
  after_validation :reverse_geocode

  acts_as_copy_target

  def find_within(distance)
    distance ||= 3
    self.nearbys(distance)
  end

  def self.find_or_create_by_location_data(location_data)
    binding.pry
    geocoder_response = Geocoder.search([location_data.latitude, location_data.longitude]).first
    Location.find_or_create_by(zip_code: geocoder_response.first.postal_code)
  end

  def self.default_development_location
    DefaultLocation.new(41.85, -87.65)
  end
end
