class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :user_id
      t.text :info
      t.jsonb :skills, null: false, default: []

      t.timestamps
    end
  end
end
