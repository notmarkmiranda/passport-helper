require 'rails_helper'

describe Venue, "validations" do
  it { should have_many(:specials)}
  it { should have_many(:passports).through(:specials)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_uniqueness_of(:name).scoped_to(:address)}
  it { should validate_presence_of(:neighborhood) }
end

describe Venue, "can return the names of a venue's passport specials" do
  before do
    create_passports(1)
    @passport = Passport.first
    create_venues(2)
    @venue_1 = Venue.first
    @venue_2 = Venue.last
    create_specials(1, @venue_1.id, @passport.id)
    create_specials(1, @venue_2.id, @passport.id)
  end

  it "can return venue 1 specials" do
    expect(@venue_1.passport_specials(@passport)).to eq Special.first.name
  end

  it "can return venue 2 specials" do
    expect(@venue_2.passport_specials(@passport)).to eq Special.last.name
  end

end

describe Venue, "can return yelp_venue" do
  before do
    create_yelp_venue(1)
    @venue_1 = Venue.first
    @yv = YelpVenue.first
  end

  it "#ratings" do
    expect(@venue_1.ratings).to eq @yv.rating_url
  end

  it "#review_number" do
    expect(@venue_1.review_number).to eq @yv.review_count
  end

  it "#yurl" do
    expect(@venue_1.yurl).to eq @yv.yelp_url
  end

  it "#yid" do
    expect(@venue_1.y_id).to eq @yv.yelp_id
  end
end
