class CreateCompetencies < ActiveRecord::Migration
  def change
    create_table :competencies do |t|
      t.belongs_to :assessment
      t.belongs_to :provider

      t.timestamps
    end
  end
end
