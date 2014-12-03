class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.belongs_to :provider
      t.belongs_to :insurance

      t.timestamps
    end
  end
end
