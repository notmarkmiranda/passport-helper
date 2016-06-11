require "rails_helper"

describe "user-passports controller" do
  describe "get /users/user_id/passports/id" do
    before do
      create_users(1)
      @user = User.first
      create_passports(1)
      @passport = Passport.first
      create_user_passports(1, @user.id, @passport.id)
    end

    it "returns a passport that a user has" do
      get "/users/#{@user.id}/passports/#{@passport.id}"
      expect(response.status).to eq 200
    end

    it "assigns passport" do
      get "/users/#{@user.id}/passports/#{@passport.id}"
      expect(assigns(:group)).to eq(@group)
    end

    it "assigns passport" do
      venues = @passport.venues
      get "/users/#{@user.id}/passports/#{@passport.id}"
      expect(assigns(:venues)).to eq(venues)
    end

    it "assigns passport" do
      up = UserPassport.find_by(user_id: @user.id, passport_id: @passport.id)
      get "/users/#{@user.id}/passports/#{@passport.id}"
      expect(assigns(:up)).to eq(up)
    end
  end
end
