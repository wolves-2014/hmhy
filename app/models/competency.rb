class Competency < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :provider

  validates :assessment, :provider, presence: true
  validates :provider, uniqueness: { scope: :assessment }

  def self.provider_ids_linked_for_assessments(providers, assessments)
  	where(provider_id: providers.map(&:id)).where(assessment_id: assessments.map(&:id)).map(&:provider_id)
  end
end
