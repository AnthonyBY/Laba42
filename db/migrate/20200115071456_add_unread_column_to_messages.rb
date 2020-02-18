class AddUnreadColumnToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :read_status, :integer, default: 0, null: false
  end
end
