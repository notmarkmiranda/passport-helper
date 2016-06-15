require "rails_helper"

describe "admin-users controller" do
  describe "get /admin/users/" do
    before do
      create_users(2)
      ApplicationController.any_instance.stubs(:require_admin).returns(true)
    end

    it "returns the index template for users" do
      get "/admin/users"
      expect(response).to render_template("index")
    end

    it "assigns users" do
      users = User.all
      get "/admin/users"
      expect(assigns(:users)).to eq users
    end
  end
end
