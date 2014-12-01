class Provider < ActiveRecord::Base
  belongs_to :location
  has_many :competencies
  has_many :assessments, through: :competencies

  attr_accessor :zip_code

  validates :name, :profile_url, :phone_number, presence: true
  # validates :profile_url, uniqueness: true

  def self.match(assessments, locations)
    providers_by_location = locations.map{|location| location.providers.to_a}
    providers_by_location = providers_by_location.flatten.uniq

    providers_by_assessment = providers_by_location.map do |provider|
      matching_assessments = provider.assessments & assessments
      provider if matching_assessments.count == assessments.count
    end
    providers_by_assessment.delete(nil)
    providers_by_assessment
  end
end
