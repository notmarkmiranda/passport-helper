require 'rails_helper'

feature "add passports to account" do
  before do
    Capybara.current_session.driver.header 'Referer', root_path
    create_passports(1)
  end

  scenario "visitor cannot" do
    visit "/passports"
    expect(page).to_not have_link("Add to My Account")
  end

  describe "user can add passports" do

    before do
      create_users(1)
      user = User.first
      ApplicationController.any_instance.stubs(:current_user).returns(user)
    end

    it "logged-in user sees link to add passport" do
      visit "/passports"
      expect(page).to have_button("Add to My Account")
    end

    it "logged-in user can add to passport from index page" do
      visit "/passports"
      click_button "Add to My Account"
      expect(page).to have_content("Added to Your Account!")
      expect(current_path).to eq "/passports"
    end

    it "logged-in user can't add passport twice" do
      visit "/passports"
      click_button "Add to My Account"
      expect(page).to_not have_button "Add to My Account"
      # expect(page).to have_content("You've already added that passport to your account!")
      expect(current_path).to eq "/passports"
    end

    it "logged-in user can add to passport from show page" do
      visit "/passports"
      click_link "Deets"
      click_button "Add to My Account"
      expect(page).to have_content("Added to Your Account!")
      expect(current_path).to eq "/passports/#{Passport.first.id}"
    end

  end

end
