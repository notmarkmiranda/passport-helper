class Notification < ActiveRecord::Base
  has_one :user_notification
  has_one :user, through: :user_notification
end
