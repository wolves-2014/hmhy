class Location < ActiveRecord::Base
  has_many :providers

  # no, it doesn't
  #before_save :latitude, :longitude, presence: true # does this do anything?
  validates :zip_code, uniqueness: true, presence: true

  acts_as_copy_target
  geocoded_by :zip_code

  after_validation :geocode
  after_validation :reverse_geocode

  reverse_geocoded_by :latitude, :longitude do |location,results|
    if geo = results.first
      location.zip_code = geo.postal_code
      location.latitude = geo.latitude
      location.longitude = geo.longitude
    end
  end

  def self.find_or_create_by_loc_data(loc_data)
    full_location_data = Geocoder.search([loc_data.latitude, loc_data.longitude]).first
    Location.find_or_create_by(zip_code: full_location_data.postal_code)
  end

  def self.development_location
    # Default to Chicago

    DefaultLocation = Struct.new(:latitude, :longitude)
    DefaultLocation.new(48, 32)
  end
end
