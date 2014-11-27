class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|

      t.timestamps
    end
  end
end
