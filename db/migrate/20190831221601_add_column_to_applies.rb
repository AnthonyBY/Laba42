class AddColumnToApplies < ActiveRecord::Migration[5.2]
  def change
    add_column :applies, :apply_status, :integer, default: 0, null: false
  end
end
