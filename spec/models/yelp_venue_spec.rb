require "rails_helper"

describe YelpVenue, "validations" do
  it { should validate_presence_of(:venue_id) }
  it { should validate_presence_of(:yelp_id) }
  xit { should validate_uniqueness_of(:venue_id).scoped_to(:yelp_id) }
  it { should validate_presence_of(:rating_url) }
  it { should validate_presence_of(:yelp_url) }
end
