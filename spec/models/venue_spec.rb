require 'rails_helper'

describe Venue, "validations" do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_uniqueness_of(:name).scoped_to(:address)}
  it { should validate_presence_of(:neighborhood) }
end
