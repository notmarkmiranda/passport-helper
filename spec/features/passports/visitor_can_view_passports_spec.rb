require 'rails_helper'

RSpec.feature "Passport index", type: :feature do
  before do
    create_passports(2)
    first = Passport.first
    last  = Passport.last
  end

  it "visitor can view passport index" do
    visit "/"
    click_link "Passports"
    expect(page).to have_css("div.card", count: 2)
  end

end
