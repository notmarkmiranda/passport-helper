require 'rails_helper'

feature "user can delete passport from their account" do
  before do
    create_users(1)
    create_passports(1)
    @user = User.first
    @passport = Passport.first
    create_user_passports(1, @user.id, @passport.id)
    ApplicationController.any_instance.stubs(:current_user).returns(@user)
  end

  it "removes a passport from their account" do
    visit "/dashboard"
    expect(page).to have_content @passport.name
    click_button "Remove from My Account"
    expect(page).to_not have_content @passport.name
  end

end
