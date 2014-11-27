class CreateIndications < ActiveRecord::Migration
  def change
    create_table :indications do |t|

      t.timestamps
    end
  end
end
