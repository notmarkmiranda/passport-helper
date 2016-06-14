require 'rails_helper'

feature "udpate profile" do
  before do
    Capybara.current_session.driver.header 'Referer', root_path
    create_users(1)
    @user = User.last
    ApplicationController.any_instance.stubs(:current_user).returns(@user)
  end

  xit "updates a users name" do
    old_name = @user.name

    visit user_dashboard_path
    click_link "Edit Profile"
    within('.main-body') do
      fill_in "user[name]", with: "Mark Miranda"
    end
    click_button "Update Profile!"

    visit user_dashboard_path
    within('.main-body') do
      expect(page).to have_content("Mark Miranda")
      expect(page).to_not have_content(old_name)
    end
  end
end
