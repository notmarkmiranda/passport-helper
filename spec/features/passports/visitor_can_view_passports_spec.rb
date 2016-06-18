require 'rails_helper'

RSpec.feature "Viewing Passports", type: :feature do
  before do
    create_passports(2)
    @first = Passport.first
    @last  = Passport.last
  end

  it "visitor can view passport index" do
    visit "/"
    first(:link, "Passports").click
    expect(page).to have_css("div.card", count: 2)
  end

  it "visitor can view passport show" do
    visit "/"
    first(:link, "Passports").click
    click_link(@first.name)
    expect(page).to have_content(@first.name)
  end

  it "visitor can view passport show - other link" do
    visit "/"
    first(:link, "Passports").click
    click_link(@last.name)
    expect(page).to have_content(@last.name)
  end

end
