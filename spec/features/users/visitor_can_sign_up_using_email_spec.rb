require 'rails_helper'

feature "visitor using e-mail" do
  before do
    Capybara.current_session.driver.header 'Referer', root_path
  end

  scenario "can sign up with all required credentials" do
    visit "/"
    first(:link, "Login or Register").click
    fill_in "user[email]", with: "markmiranda51@gmail.com"
    fill_in "user[password]", with: "password"
    fill_in "user[name]", with: "Mark Miranda"
    click_button "Create New Account!"
    expect(page).to have_content "Thanks for signing up!"
    expect(current_path).to eq user_dashboard_path
  end

  scenario "cannot sign up while missing password" do
    visit "/"
    first(:link, "Login or Register").click
    fill_in "user[email]", with: "markmiranda51@gmail.com"
    click_button "Create New Account!"
    expect(current_path).to eq root_path
    expect(page).to have_content "Password is too short (minimum is 8 characters)"
  end

  scenario "cannot sign up while missing email" do
    visit "/"
    first(:link, "Login or Register").click
    fill_in "user[password]", with: "password"
    click_button "Create New Account!"
    expect(current_path).to eq root_path
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Email is invalid"
  end


end
