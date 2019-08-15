class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.text :info
      t.jsonb :skills, null: false, default: []

      t.timestamps
    end
  end
end
