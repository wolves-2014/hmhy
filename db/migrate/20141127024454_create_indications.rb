class CreateIndications < ActiveRecord::Migration
  def change
    create_table :indications do |t|
      t.belongs_to :feeling, index: true
      t.belongs_to :assessment, index: true

      t.timestamps
    end
  end
end
