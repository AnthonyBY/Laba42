class AddSomeInfoToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, default: "", null: false
    add_column :users, :surname_name, :string, default: "", null: false
    add_column :users, :company_name, :string, default: "", null: false
    add_column :users, :phone_number, :string, default: "", null: false
    add_column :users, :city, :string, default: "", null: false
  end
end
