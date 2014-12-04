class Target < ActiveRecord::Base
  belongs_to :age_group
  belongs_to :provider

  validates :age_group, :provider, presence: true
  validates :provider, uniqueness: { scope: :age_group}
end
