class Location < ActiveRecord::Base
  has_many :residences
  has_many :providers, through: :residences

  validates :lat, :lng, presence: true
  validates :zip_code, uniqueness: true, presence: true

  acts_as_copy_target

  # scope :close_to, -> (lat, lng, distance_in_miles = 5) {
  #   where(%{
  #     ST_DWithin(
  #       ST_GeographyFromText(
  #         'SRID=4326;POINT(' || location.lng || ' ' || location.lat || ')'
  #       ),
  #       ST_GeographyFromText('SRID=4326;POINT(%f %f)'),
  #       %d
  #     )
  #   } % [longitude, latitude, distance_in_meters])
  # }
end
