class AddUniqueConstraints < ActiveRecord::Migration[5.2]
  def change
    add_index :applies, [:project_id, :user_id], unique: true
  end
end
