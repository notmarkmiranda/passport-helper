require "rails_helper"

describe Group, 'validations' do
  it { should have_many(:memberships) }
  it { should have_many(:users).through(:memberships) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end

describe Group, 'members' do
  before do
    create_users(3)
    user1 = User.first
    user2 = User.second
    user3 = User.last
    create_groups(3)
    @group1 = Group.first
    @group2 = Group.second
    @group3 = Group.last
    Membership.create(user_id: user1.id, group_id: @group1.id)
    Membership.create(user_id: user1.id, group_id: @group2.id)
    Membership.create(user_id: user2.id, group_id: @group2.id)
    Membership.create(user_id: user1.id, group_id: @group3.id)
    Membership.create(user_id: user2.id, group_id: @group3.id)
    Membership.create(user_id: user3.id, group_id: @group3.id)
  end

  it "can return the number of members in a group" do
    expect(@group1.membership_count).to eq 1
    expect(@group3.membership_count).to eq 3
    expect(@group2.membership_count).to eq 2
  end
end
