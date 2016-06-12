require "rails_helper"

describe "visits controller - API" do
  before do
    create_visits(1)
    create_yelp_venue(1)
    user = User.first
    ApplicationController.any_instance.stubs(:current_user).returns(user)
  end

  it "VisitsController#index" do
    venue = Venue.first.id
    up = UserPassport.first.id
    get "/api/v1/visits"
    expected = JSON.parse(response.body).first
    expect(expected["venue_id"]).to eq venue
    expect(expected["user_passport_id"]).to eq up
  end
end

describe "visits controller - API #create" do
  before do
    create_users(1)
    user = User.first
    create_yelp_venue(1)
    create_passports(1)
    pass = Passport.first
    create_user_passports(1, user.id, pass.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
  end
  it "VisitsController#create" do
    yv = YelpVenue.first
    up = UserPassport.first
    post "/api/v1/visits", {venue: {yelp_id: yv.yelp_id, up_id: up.id}}
    expected = Visit.last
    expect(expected.venue_id).to eq yv.venue_id
    expect(expected.user_passport_id).to eq up.id
  end
end

describe "visits controller - API #destroy" do
  before do
    create_users(1)
    user = User.first
    create_yelp_venue(1)
    create_passports(1)
    pass = Passport.first
    create_user_passports(1, user.id, pass.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)
  end
  it "VisitsController#create" do
    yv = YelpVenue.first
    up = UserPassport.first
    delete "/api/v1/visits", {venue: {yelp_id: yv.yelp_id, up_id: up.id}}
    expected = JSON.parse(response.body)
    expect(expected["status"]).to eq 200
  end
end
