class Indication < ActiveRecord::Base
  belongs_to :feeling
  belongs_to :assessment

  validates :feeling, :assessment, presence: true
  validates :feeling, uniqueness: { scope: :assessment }
end
