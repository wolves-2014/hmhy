class Location < ActiveRecord::Base
  has_many :providers

  before_save :latitude, :longitude, presence: true # does this do anything?
  validates :zip_code, uniqueness: true, presence: true

  geocoded_by :zip_code
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    geo = results.first
    obj.zip_code = geo.postal_code
    obj.latitude = geo.latitude
    obj.longitude = geo.longitude
  end
  after_validation :reverse_geocode

  acts_as_copy_target

  def Location.by_ip_address(location_data)
    location_data = Geocoder.search('74.122.9.196').first if location_data.ip == "127.0.0.1"
    Location.find_or_create_by(latitude: location_data.latitude, longitude: location_data.longitude)
  end
end
