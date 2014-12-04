class AddIndexLocationProvider < ActiveRecord::Migration
  def change
    add_index :providers, :location_id
    add_index :competencies, [:assessment_id, :provider_id]
  end
end


