class Location < ActiveRecord::Base
  has_many :providers

  before_save :latitude, :longitude, presence: true # does this do anything?
  validates :zip_code, uniqueness: true, presence: true

  geocoded_by :zip_code
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    geo = results.first
    # if existing_location = Location.find_by(zip_code: geo.postal_code)
    #   binding.pry
    #   obj = existing_location
    # else
      obj.zip_code = geo.postal_code
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
    # end
  end
  after_validation :reverse_geocode

  acts_as_copy_target

  def self.by_ip_address(request_data)
    request_data.ip == "127.0.0.1" ? loc_data = Geocoder.search('74.122.9.196').first : loc_data = request_data
    full_location_data = Geocoder.search([loc_data.latitude, loc_data.longitude]).first
    Location.find_or_create_by(zip_code: full_location_data.postal_code)
  end
end
