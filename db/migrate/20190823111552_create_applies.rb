class CreateApplies < ActiveRecord::Migration[5.2]
  def change
    create_table :applies do |t|
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
