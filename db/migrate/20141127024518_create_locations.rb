class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :zip_code
      t.float :latitude
      t.float :longitude

    end
    add_index :locations, [:latitude, :longitude]
  end
end
