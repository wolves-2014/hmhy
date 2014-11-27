class Residence < ActiveRecord::Base
  belongs_to :location
  belongs_to :provider

  validates :provider, uniqueness: { scope: :location, message: "is already registered in this relation." }
end
