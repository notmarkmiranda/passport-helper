require 'rails_helper'

feature "udpate profile" do
  before do
    Capybara.current_session.driver.header 'Referer', root_path
    create_users(1)
    @user = User.last
    ApplicationController.any_instance.stubs(:current_user).returns(@user)
  end


end
