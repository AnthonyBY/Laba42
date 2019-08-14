class AddSkillsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :skills, :jsonb, null: false, default: []
  end
end
