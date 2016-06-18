class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :notification, index: true, foreign_key: true
    end
  end
end
