require 'rails_helper'

describe PagesController do

  it "sends to an index page" do
    get :index
    expect(response).to render_template(:index)
  end

  it "sends to a dashboard page" do
    get :dashboard
    expect(response).to render_template(:dashboard)
  end

end
