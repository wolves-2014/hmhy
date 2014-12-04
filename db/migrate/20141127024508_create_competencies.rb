class CreateCompetencies < ActiveRecord::Migration
  def change
    create_table :competencies do |t|
      t.belongs_to :assessment, index: true
      t.belongs_to :provider, index: true

      t.timestamps
    end
  end
end
