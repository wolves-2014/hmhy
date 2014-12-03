class Insurance < ActiveRecord::Base
  has_many :networks
  has_many :providers, through: :networks

  validates :name, uniqueness: true, presence: true
end
