require 'rails_helper'

describe MembershipsController do
  describe "destroy" do
    before do
      request.env["HTTP_REFERER"] = root_path
      create_users(1)
      @user = User.first
      create_groups(1)
      @group = Group.first
      @m = @user.memberships.create(group_id: @group.id)
    end

    it "can remove groups from an account" do
      session[:user_id] = @user.id
      expect(@user.groups.count).to eq 1
      delete :destroy, id: @group.id
      expect(@user.groups.count).to eq 0
    end
  end
end