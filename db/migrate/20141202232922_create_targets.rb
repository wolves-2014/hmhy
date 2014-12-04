class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.belongs_to :provider
      t.belongs_to :age_group

      t.timestamps
    end
  end
end
