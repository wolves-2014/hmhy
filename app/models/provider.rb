class Provider < ActiveRecord::Base
  has_many :competencies
  has_many :assessments, through: :competencies
  has_many :residences
  has_many :locations, through: :residences

  validates :name, :profile_url, :phone_number, presence: true
  validates :profile_url, uniqueness: true

  def self.match(assessments, locations)
    # binding.pry
    providers_by_location = locations.map{|location| location.providers.to_a}
    providers_by_assessment = assessments.map{|assessment| assessment.providers.to_a}
    providers = providers_by_assessment.flatten.uniq & providers_by_location.flatten.uniq
    providers[0..4] #must be changed
  end


end
