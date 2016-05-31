require "rails_helper"

feature "visitor using e-mail" do
  scenario "can sign up with all required credentials" do
    visit "/"
    click_link "Login or Register"
    fill_in "user[email]", with: "markmiranda51@gmail.com"
    fill_in "user[password]", with: "password"
    click_button "Create Account!"
    expect(current_path).to eq complete_registration_path
    expect(page).to have_content "Thanks for signing up!"
    expect(page).to have_content "We're almost done!"
    fill_in "Name", with: "Mark Miranda"
    fill_in "Profile Photo", with: "http://www.addictedtoibiza.com/wp-content/uploads/2012/12/example.png"
    click_button "Complete Registration!"
    expect(current_path).to eq user_dashboard_path
    expect(page).to have_content "Name: Mark Miranda"
    expect(page).to have_content "Email: markmiranda51@gmail.com"
  end

  scenario "cannot sign up while missing password" do
    visit "/"
    click_link "Login or Register"
    fill_in "user[email]", with: "markmiranda51@gmail.com"
    click_button "Create Account!"
    expect(current_path).to eq "/users"
    expect(page).to have_content "Password is too short (minimum is 8 characters)"
  end

  scenario "cannot sign up while missing email" do
    visit "/"
    click_link "Login or Register"
    fill_in "user[password]", with: "password"
    click_button "Create Account!"
    expect(current_path).to eq "/users"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Email is invalid"
  end


end
