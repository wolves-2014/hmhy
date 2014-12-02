# kill this?
class Residence < ActiveRecord::Base
  belongs_to :location
  belongs_to :provider

  validates :location, :provider, presence: true
  validates :provider, uniqueness: { scope: :location }
end
