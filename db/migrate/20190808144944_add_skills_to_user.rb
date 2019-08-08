class AddSkillsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :skills, :jsonb
  end
end
