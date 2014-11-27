class CreateCompetencies < ActiveRecord::Migration
  def change
    create_table :competencies do |t|

      t.timestamps
    end
  end
end
