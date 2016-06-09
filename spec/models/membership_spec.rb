require 'rails_helper'

describe Membership, "validations" do
  it { should belong_to(:group) }
  it { should belong_to(:user) }
  xit { should validate_uniqueness_of(:user_id).scoped_to(:group).with_message("You're already a part of that group!")}
end
