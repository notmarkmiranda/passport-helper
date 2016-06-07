require 'rails_helper'

describe PassportsController do

  it "assigns @passports" do
    passports = Passport.all
    get :index
    expect(assigns(:passports)).to eq(passports)
  end

  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end

end
