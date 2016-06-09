require 'rails_helper'

describe UserPassportsController do
  describe "destroy" do
    before do
      request.env["HTTP_REFERER"] = root_path
      create_passports(1)
      @passport = Passport.first
      create_users(1)
      @user = User.first
      @up = UserPassport.create(passport_id: @passport.id, user_id: @user.id)
    end

    it "can delete passports" do
      session[:user_id] = @user.id
      expect(@user.passports.count).to eq 1
      delete :destroy, id: @passport.id
      expect(@user.passports.count).to eq 0
    end
  end
end
