class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :title
      t.string :name
      t.string :photo_url
      t.string :profile_url
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
