class AddEmployeeToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :employee, :integer, default: 0, null: false
  end
end
