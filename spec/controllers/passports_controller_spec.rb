require 'rails_helper'

describe PassportsController do
  describe "index" do
    it "assigns active_passports" do
      active_passports = Passport.active_passports
      get :index
      expect(assigns(:active_passports)).to eq(active_passports)
    end

    it "assigns inactive_passports" do
      inactive_passports = Passport.inactive_passports
      get :index
      expect(assigns(:inactive_passports)).to eq(inactive_passports)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "show" do
    before do
      create_passports(1)
      @passport = Passport.first
    end

    it "assigns single passport" do
      get :show, id: @passport.id
      expect(assigns(:passport)).to eq (@passport)
    end

    it "renders the show template" do
      get :show, id: @passport.id
      expect(response).to render_template("show")
    end
  end


end
