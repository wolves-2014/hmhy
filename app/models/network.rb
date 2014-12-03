class Network < ActiveRecord::Base
  belongs_to :insurance
  belongs_to :provider

  validates :insurance, :provider, presence: true
  validates :provider, uniqueness: { scope: :insurance}
end
