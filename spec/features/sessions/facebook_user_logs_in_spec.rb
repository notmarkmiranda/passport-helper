require 'rails_helper'

feature "facebook user logs in" do
  before do
    Capybara.current_session.driver.header 'Referer', root_path
  end

  scenario "with valid credentials" do
    visit facebook_login_path
    expect(page).to have_content "Welcome, Mark Miranda!"
  end

  xscenario "with invalid credentials" do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    visit facebook_login_path
    expect(page).to have_content "That didn't work, try again."
  end

end
