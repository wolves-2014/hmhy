class Provider < ActiveRecord::Base
  has_many :competencies
  has_many :assessments, through: :competencies
  has_many :residences
  has_many :locations, through: :residences

  validates :name, :profile_url, :phone_number, presence: true
  validates :profile_url, uniqueness: true

  def self.match(assessments)
    providers = assessments.map{|assessment| assessment.providers.to_a}
    providers.flatten.uniq
  end
end
