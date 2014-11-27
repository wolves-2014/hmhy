class CreateResidences < ActiveRecord::Migration
  def change
    create_table :residences do |t|
      t.belongs_to :provider
      t.belongs_to :location

      t.timestamps
    end
  end
end
