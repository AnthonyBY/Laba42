class AddTypeAndCostToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :project_type, :integer, default: 0, null: false
    add_column :projects, :cost, :integer, default: 0, null: false
    add_column :projects, :cost_type, :integer, default: 0, null: false
    add_column :projects, :deadline, :date, null: false
  end
end
