class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.belongs_to :provider, index: true
      t.belongs_to :age_group, index: true

      t.timestamps
    end
  end
end
