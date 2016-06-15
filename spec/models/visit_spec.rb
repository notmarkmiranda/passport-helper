require "rails_helper"

describe Visit, "validations" do
  it { should belong_to(:user_passport) }
  it { should belong_to(:venue) }
end

describe Visit do
  before do
    create_visits(1)
    @visit = Visit.first
    @venue = Venue.first.id
    @up = UserPassport.first.id
  end

  it "#get_visit" do
    a = Visit.get_visit(@venue, @up)
    expect(a.venue_id).to eq @venue
    expect(a.user_passport_id).to eq @up
  end

  it "#average_visits" do
    create_venues(2)
    expect(Visit.average_visits).to eq 0.33
  end
end
