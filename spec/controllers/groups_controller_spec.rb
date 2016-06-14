require 'rails_helper'

describe GroupsController do
  context "index" do
    it "assigns groups" do
      groups = Group.where.not(id: [1,2])
      get :index
      expect(assigns(:groups)).to eq(groups)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  context "show" do
    it "assigns group" do
      create_groups(1)
      group = Group.first
      get :show, id: Group.first.id
      expect(assigns(:group)).to eq(group)
    end
  end

  context "new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end

    it "assigns group" do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end
  end

  context "create" do

    it "breaks when something is wrong" do
      request.env["HTTP_REFERER"] = root_path
      post :create, group: {passport_id: 1, user_id: 1}
      expect(response).to redirect_to root_path
    end

  end
end
