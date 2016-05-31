require 'rails_helper'

describe UsersController do

  it "posts create a new user" do
    expect(session[:user_id]).to be_nil
    expect {
      post :create, {user: {provider: "email", email: "markmiranda51@gmail.com", password: "password"}}
    }.to change(User, :count).by(1)
    expect(session[:user_id]).to_not be_nil
    expect(flash[:success]).to be_present
    expect(response).to redirect_to complete_registration_path
  end

  it "users_controller#complete" do
    get :complete
    expect(response).to render_template(:complete)
  end

  it "users_controller#update" do
    user = User.create(email: "markmiranda51@gmail.com", password: "password", provider: "email")
    session[:user_id] = user.id
    patch :update, id: user.id, user: { name: "Mark Miranda" }
    expect(response).to redirect_to(user_dashboard_path)
  end

end