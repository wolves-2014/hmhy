class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :zip_code
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
