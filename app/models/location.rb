class Location < ActiveRecord::Base
  has_many :residences
  has_many :providers, through: :residences

  validates :zip_code, uniqueness: true, presence: true
end
