require "rails_helper"

describe AdminController do
  context "show" do
    before do
      User.create(provider: "email",
      name: "Mark Miranda",
      image_url: "http://placehold.it/250x250",
      url: "http://google.com",
      email: "a@b.com",
      password: "password",
      role: 1)
      user = User.last
      ApplicationController.any_instance.stubs(:current_user).returns(user)
    end

    it "assigns variables" do
      @users = User.all
      @ups = UserPassport.all
      @groups = Group.all
      @passports = Passport.all
      @venues = Venue.all
      @visits = Visit.all
      get :show
      expect(assigns(:users)).to eq(@users)
      expect(assigns(:ups)).to eq(@ups)
      expect(assigns(:groups)).to eq(@groups)
      expect(assigns(:passports)).to eq(@passports)
      expect(assigns(:venues)).to eq(@venues)
      expect(assigns(:visits)).to eq(@visits)

    end

    it "renders the show template" do
      get :show
      expect(response).to render_template("show")
    end

  end
end
