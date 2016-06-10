require "rails_helper"

feature "new group" do
  before do
    create_users(1)
    create_passports(1)
    user = User.first
    ApplicationController.any_instance.stubs(:current_user).returns(user)
  end

  it "user can create a new group" do
    visit "/dashboard"
    click_link "Create a New Group"
    fill_in "Group Name", with: "test"
    find("#group-select").find(:xpath, 'option[2]').select_option
    click_button "Create Group!"
    expect(page).to have_content "test Group Created!"
  end
end
