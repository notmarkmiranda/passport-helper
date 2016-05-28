require 'rails_helper'

describe SessionsController do

  it "creates or finds user from auth hash and redirects to home" do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    post :create, provider: :facebook
    expect(response).to redirect_to root_path
    expect(session[:user_id]).to_not be_nil
  end

  it "invalid credentials test" do
    post :create, provider: :facebook
    expect(flash[:warning]).to be_present
    expect(response).to redirect_to root_path
  end

  describe "sessions#destroy" do

    before do
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
      post :create, provider: :facebook
    end

    it "destroys a sessions" do
      expect(session[:user_id]).to_not be_nil
      get :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to root_path
    end
  end
end
