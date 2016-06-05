require 'rails_helper'

describe Venue, "validations" do
  it { should have_many(:specials)}
  it { should have_many(:passports).through(:specials)}

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_uniqueness_of(:name).scoped_to(:address)}
  it { should validate_presence_of(:neighborhood) }
end
