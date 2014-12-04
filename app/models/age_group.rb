class AgeGroup < ActiveRecord::Base
  has_many :targets
  has_many :providers, through: :targets

  validates :generation, uniqueness: true, presence: true
end
