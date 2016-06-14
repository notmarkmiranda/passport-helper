require 'rails_helper'

describe UsersController do
  before do
    request.env["HTTP_REFERER"] = root_path
    create_users(1)
    user = User.first
    ApplicationController.any_instance.stubs(:current_user).returns(user)
  end

  it "posts create a new user" do
    expect(session[:user_id]).to be_nil
    expect {
      post :create, { user: { provider: "email", email: "markmiranda51@gmail.com", name: "Mark Miranda", password: "password" } }
    }.to change(User, :count).by(1)
    expect(session[:user_id]).to_not be_nil
    expect(flash[:success]).to be_present
    expect(response).to redirect_to root_path
  end

  it "users_controller#update" do
    user = User.create(email: "markmiranda51@gmail.com", password: "password", name: "Mark Miranda", provider: "email")

    expect(user.name).to eq "Mark Miranda"
    session[:user_id] = user.id
    patch :update, {id: user.id, user: { name: "NEW NAME" }}
    expect(response).to redirect_to(user_dashboard_path)
    user = User.last
    expect(user.name).to eq "NEW NAME"
  end

  it "users_controller#show" do
    get :show
    expect(response).to render_template(:show)
  end

  it "users_controller#edit" do
    user = User.first
    get :edit, id: user.id
    expect(response).to render_template(:edit)
  end

end

describe UsersController, "sad path" do
  it "redirects to root path" do
    get :show
    expect(response).to redirect_to root_path
  end
end
