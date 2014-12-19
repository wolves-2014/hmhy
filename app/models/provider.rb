class Provider < ActiveRecord::Base
  belongs_to :location
  has_many :competencies
  has_many :assessments, through: :competencies
  has_many :networks
  has_many :insurances, through: :networks
  has_many :targets
  has_many :age_groups, through: :targets

  attr_accessor :zip_code, :distance

  validates :name, :profile_url, :phone_number, presence: true
  # validates :profile_url, uniqueness: true

  def register_new(provider_data)
    location = Location.find_or_create_by(zip_code: provider_data[:zip_code])
    competencies = provider_data[:competencies].select{|k, v| v == 1}.keys
    provider = location.providers.new(provider_data)
    if provider.save
      competencies.each do |competency|
        assessment = Assessment.find_by(word: competency)
        provider.competencies.create(assessment: assessment)
      end
    end
  end

  def treatment_for?(provided_assessments)
    assessment_ids = provided_assessments.map{|assessment| id}
    self.assessments.where(id: assessment_ids).count
  end

  def distance_from(location)
    @distance ||= self.location.distance_from(location)
    (@distance * 10).round / 10.0
  end

  def self.find_for_locations(locations)
    where(location_id: locations.map(&:id)).includes(:location)
  end
end
