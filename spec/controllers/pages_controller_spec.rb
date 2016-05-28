require 'rails_helper'

describe PagesController do

  it "sends to an index page" do
    get :index
    expect(response).to render_template(:index)
  end
end
