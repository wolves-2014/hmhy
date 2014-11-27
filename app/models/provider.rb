class Provider < ActiveRecord::Base
  has_many :competencies
  has_many :residences
  has_many :locations, through: :residences

  validates :name, :profile_url, :phone_number, presence: true
end
