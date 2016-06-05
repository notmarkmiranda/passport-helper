require 'rails_helper'

describe Passport, 'validations' do
  it { should have_many(:user_passports) }
  it { should have_many(:users).through(:user_passports)}

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:start) }
  it { should validate_presence_of(:expiration) }
  it { should validate_presence_of(:status) }
end
