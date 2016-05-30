require "rails_helper"

feature "visitor can sign up via e-mail" do
  scenario "with all required credentials" do
    visit "/"
    click_link "Login or Register"
    fill_in "E-Mail", with: "markmiranda51@gmail.com"
    fill_in "Password", with: "password"
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
end
