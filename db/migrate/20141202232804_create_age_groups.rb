class CreateAgeGroups < ActiveRecord::Migration
  def change
    create_table :age_groups do |t|
      t.string :generation

      t.timestamps
    end
  end
end
