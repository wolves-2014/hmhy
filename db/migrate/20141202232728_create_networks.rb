class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.belongs_to :provider, index: true
      t.belongs_to :insurance, index: true

      t.timestamps
    end
  end
end
