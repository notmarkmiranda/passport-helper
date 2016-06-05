require 'rails_helper'

describe Special, 'validations' do
  it { should belong_to(:venue) }
  it { should belong_to(:passport) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:venue_id) }
  it { should validate_presence_of(:passport_id) }
  xit { should validate_uniqueness_of(:passport_id).scoped_to(:venue_id) }
end
