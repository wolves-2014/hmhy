class Location < ActiveRecord::Base
  has_many :residences
  has_many :providers, through: :residences

  validates :latitude, :longitude, presence: true
  validates :zip_code, uniqueness: true, presence: true

  geocoded_by :zip_code
  after_validation :geocode

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    # binding.pry
    # obj.update(zip_code: geo.postal_code.to_i) if geo = results.first
  end
  after_validation :reverse_geocode

  acts_as_copy_target

  # def address=(zip)
  #   # revisit this if we want to create locations
  # end
end
