class ChangeIndexOnUsers < ActiveRecord::Migration
  def change
    remove_index :users, :uid
    add_index :users, :email
    add_index :users, [:provider, :uid], unique: true
  end
end
