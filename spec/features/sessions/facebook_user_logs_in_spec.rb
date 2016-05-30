require "rails_helper"

feature "facebook user logs in" do

  xscenario "with valid credentials" do
    # visit "/"
    # click_link "Login"
    # find('img.facebook-login').click
    expect(current_path).to eq user_dashboard_path
    expect(page).to have_content "Name: Mark Miranda"
    expect(flash[:success]).to be_present
    # save_and_open_page
  end

end
