class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :zip_code
      t.decimal :lat, precision: 9, scale: 6
      t.decimal :lng, precision: 9, scale: 6

      t.timestamps
    end
  end
end
