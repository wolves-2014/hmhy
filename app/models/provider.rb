class Provider < ActiveRecord::Base
  belongs_to :location
  has_many :competencies
  has_many :assessments, through: :competencies

  attr_accessor :zip_code

  validates :name, :profile_url, :phone_number, presence: true
  # validates :profile_url, uniqueness: true

  def treatment_for?(provided_assessments)
    (self.assessments & provided_assessments).count == provided_assessments.count
  end

  def distance_from(location)
    distance = self.location.distance_from(location)
    (distance * 10).round / 10.0
  end
end
