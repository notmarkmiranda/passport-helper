require 'rails_helper'

feature "email user" do

  before do
    create_users(1)
    @user = User.first
  end

  scenario "can log in with valid credentials" do
    visit "/"
    click_link "Login or Register"
    fill_in "session[email]", with: @user.email
    fill_in "session[password]", with: "password"
    click_on "Let's Go!"
    expect(current_path).to eq user_dashboard_path
    expect(page).to have_content "Welcome #{@user.name}!"
  end

  scenario "cannot log in with invalid password" do
    visit "/"
    click_link "Login or Register"
    fill_in "session[email]", with: @user.email
    fill_in "session[password]", with: "passwordz"
    click_button "Let's Go!"
    expect(page).to have_content "That didn't work, try again."
    expect(current_path).to eq "/"
  end

  scenario "cannot log in with invalid email" do
    visit "/"
    click_link "Login or Register"
    fill_in "session[email]", with: "a@b.com"
    fill_in "session[password]", with: "password"
    click_button "Let's Go!"
    expect(page).to have_content "That didn't work, try again."
    expect(current_path).to eq "/"
  end

end
