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
