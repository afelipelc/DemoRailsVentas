class AddUsernameUsers < ActiveRecord::Migration
  def change
  	add_column :users, :username, :string,  null: false, default: ""
  end
  add_index :users, :username, unique: true
end
