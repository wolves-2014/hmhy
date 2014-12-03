class Age < ActiveRecord::Base
  has_many :targets
  has_many :providers, through: :targets

  validates :age_group, uniqueness: true, presence: true
end
