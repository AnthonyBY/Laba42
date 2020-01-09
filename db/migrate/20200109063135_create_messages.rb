class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text  :body_message
      t.references :user, null: false, foreign_key: true
      t.integer :recipient_id, null: false

      t.timestamps
    end
  end
end
