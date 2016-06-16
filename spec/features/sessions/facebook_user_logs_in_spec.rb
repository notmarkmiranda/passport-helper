require 'rails_helper'

feature "facebook user logs in" do
  before do
    Capybara.current_session.driver.header 'Referer', root_path
  end

  scenario "with valid credentials" do
    visit facebook_login_path
    expect(page).to have_content "Welcome, Mark Miranda!"
  end



end
