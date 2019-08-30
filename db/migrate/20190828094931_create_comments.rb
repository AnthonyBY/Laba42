
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text  :content
      t.references :user, null: false, foreign_key: true
      t.references :comment_owner, polymorphic: true, index: true
      t.timestamps
    end
  end
end
