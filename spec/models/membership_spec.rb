require 'rails_helper'

describe Membership, "validations" do
  it { should belong_to(:group) }
  it { should belong_to(:user) }
end
