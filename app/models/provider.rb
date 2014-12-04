class Provider < ActiveRecord::Base
  belongs_to :location
  has_many :competencies
  has_many :assessments, through: :competencies
  has_many :networks
  has_many :insurances, through: :networks
  has_many :targets
  has_many :age_groups, through: :targets

  attr_accessor :zip_code

  validates :name, :profile_url, :phone_number, presence: true
  # validates :profile_url, uniqueness: true

  def treatment_for?(provided_assessments)
    assessment_ids = provided_assessments.map{|assessment| id}
    self.assessments.where(id: assessment_ids).count
  end

  def distance_from(location)
    distance = self.location.distance_from(location)
    (distance * 10).round / 10.0
  end
end
