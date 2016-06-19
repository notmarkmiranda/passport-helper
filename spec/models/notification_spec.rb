require "rails_helper"

describe Notification, "validations" do
  it { should have_one(:user_notification) }
  it { should have_one(:user).through(:user_notification)}
end
