class Location < ActiveRecord::Base
  has_many :providers

  before_save :latitude, :longitude, presence: true # does this do anything?
  validates :zip_code, uniqueness: true, presence: true

  geocoded_by :zip_code
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    geo = results.first
    # obj.update(zip_code: geo.postal_code, latitude: geo.latitude, longitude: geo.longitude)
    binding.pry
    obj.zip_code = geo.postal_code
    obj.latitude = geo.latitude
    obj.longitude = geo.longitude
  end
  after_validation :reverse_geocode

  acts_as_copy_target

  def by_ip_address

  end
end
