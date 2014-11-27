class Assessment < ActiveRecord::Base
  has_many :indications
  has_many :competencies
  has_many :providers, through: :competencies

  validates :name, uniqueness: true, presence: true

end
