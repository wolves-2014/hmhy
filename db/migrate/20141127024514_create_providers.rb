class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.belongs_to :location, index: true
      t.string :title
      t.string :name
      t.string :photo_url
      t.string :profile_url
      t.string :email
      t.string :phone_number
      t.boolean :sliding_scale, default: false
      t.integer :min_price, default: 0
      t.integer :max_price, default: 0

      t.timestamps
    end
  end
end
