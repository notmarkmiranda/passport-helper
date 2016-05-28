class ChangeEmailOnUsers < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, null: true
    change_column :users, :provider, :string, null: true
  end
end
