class Competency < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :provider

  validates :assessment, :provider, presence: true
  validates :provider, uniqueness: { scope: :assessment }
end
