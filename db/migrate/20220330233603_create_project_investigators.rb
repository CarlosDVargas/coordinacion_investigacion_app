class CreateProjectInvestigators < ActiveRecord::Migration[7.0]
  def change
    create_table :project_investigators do |t|
      t.integer :project_id
      t.integer :investigator_id
      
      t.timestamps
    end
  end
end
