require "rails_helper"

describe YelpVenue, "validations" do
  it { should validate_presence_of(:venue_id) }
  it { should validate_presence_of(:yelp_id) }
  it { should validate_presence_of(:rating_url) }
  it { should validate_presence_of(:yelp_url) }
end

describe YelpVenue do
  before do
    create_yelp_venue
    @yv = YelpVenue.first
  end

  it "#venue_id_for_visit" do
    expect(YelpVenue.venue_id_for_visit(@yv.yelp_id)).to eq @yv.venue_id
  end
end
