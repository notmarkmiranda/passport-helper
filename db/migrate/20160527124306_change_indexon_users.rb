class ChangeIndexonUsers < ActiveRecord::Migration
  def change
    remove_index :users, [:provider, :uid]
  end
end
