class Competency < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :provider

  validates :provider, uniqueness: { scope: :assessment, message: "is already registered in this relation." }
end
