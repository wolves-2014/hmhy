class Target < ActiveRecord::Base
  belongs_to :age
  belongs_to :provider

  validates :age, :provider, presence: true
  validates :provider, uniqueness: { scope: :age}
end
