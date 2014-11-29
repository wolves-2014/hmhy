class Location < ActiveRecord::Base
  has_many :residences
  has_many :providers, through: :residences

  validates :latitude, :longitude, presence: true
  validates :zip_code, uniqueness: true, presence: true

  geocoded_by :zip_code
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  acts_as_copy_target
end
