class ChangeStatusOnMemberships < ActiveRecord::Migration
  def change
    change_column :memberships, :status, :integer, default: 0
  end
end
