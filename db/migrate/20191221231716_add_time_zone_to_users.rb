class AddTimeZoneToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :time_zone, :string, default: 'Minsk'
    add_index :users, :time_zone
  end
end
