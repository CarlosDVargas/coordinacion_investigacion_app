class AddColumnRoleToProjectInvestigators < ActiveRecord::Migration[7.0]
  def change
    add_column :project_investigators, :role, :integer, default: 1
  end
end
