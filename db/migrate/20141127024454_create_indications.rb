class CreateIndications < ActiveRecord::Migration
  def change
    create_table :indications do |t|
      t.belongs_to :feeling
      t.belongs_to :assessment
      t.integer :ranking

      t.timestamps
    end
  end
end
