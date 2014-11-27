class Indication < ActiveRecord::Base
  belongs_to :feeling
  belongs_to :assessment

  validates :feeling, uniqueness: { scope: :assessment, message: "is already registered in this relation." }
end
