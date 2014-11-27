class CreateFeelings < ActiveRecord::Migration
  def change
    create_table :feelings do |t|
      t.string :word

      t.timestamps
    end
  end
end
