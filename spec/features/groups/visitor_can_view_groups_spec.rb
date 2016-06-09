require "rails_helper"

feature "groups index" do
  before do
    create_groups(2)
    @group1 = Group.first
    @group2 = Group.last
  end

  it "visitor goes to index page from root" do
    visit "/"
    click_link "Groups"
    expect(page).to have_content(@group1.name)
    expect(page).to have_content(@group2.name)
  end
end
