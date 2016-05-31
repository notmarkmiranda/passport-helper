require "rails_helper"

feature "facebook user logs in" do

  scenario "with valid credentials" do
    visit facebook_login_path
    expect(page).to have_content "Welcome, Mark Miranda!"
    expect(page).to have_content "Name: Mark Miranda"
  end

  xscenario "with invalid credentials" do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit facebook_login_path
    expect(page).to have_content "That didn't work, try again."
  end

end
