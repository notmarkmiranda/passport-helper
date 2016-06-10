require 'rails_helper'

describe Passport, 'validations' do
  it { should have_many(:groups) }
  it { should have_many(:user_passports) }
  it { should have_many(:users).through(:user_passports) }
  it { should have_many(:specials) }
  it { should have_many(:venues).through(:specials) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:start) }
  it { should validate_presence_of(:expiration) }
  it { should validate_presence_of(:status) }
end
