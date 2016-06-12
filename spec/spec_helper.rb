require 'simplecov'
SimpleCov.start("rails")
require 'database_cleaner'
require 'omniauth-twitter'
require 'shoulda-matchers'
require 'capybara'
require 'launchy'
require 'pry'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

info_hash = { email: "markmiranda51@gmail.com",
  name: "Mark Miranda",
  image: "http://thesocialmediamonthly.com/wp-content/uploads/2015/08/photo.png",
  urls: "http://www.facebook.com/markmiranda51"}

info = OpenStruct.new(info_hash)

ah = { provider: "facebook",
    info: info }

auth_hash = OpenStruct.new(ah)

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(auth_hash)

def mock_auth_hash
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    "provider" => "facebook",
    "info" => {"name" => "Mark Miranda",
      "image" => "http://thesocialmediamonthly.com/wp-content/uploads/2015/08/photo.png",
      "urls" => "http://www.facebook.com/markmiranda51"}
      })
end

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

end

def create_users(num = 1)
  num.times do
    User.create(email: Faker::Internet.email,
    provider: "email",
    name: Faker::Name.name,
    password: "password")
  end
end

def create_passports(num = 1)
  num.times do
    Passport.create(name: Faker::Company.name,
    start: Date.new(2016, 1, 1),
    expiration: Date.new(2016, 12, 31),
    status: "active")
  end
end

def create_venues(num = 1)
  num.times do
    Faker::Config.locale = 'en-US'
    Venue.create(name: Faker::Company.name,
    address: Faker::Address.street_address,
    phone: Faker::PhoneNumber.cell_phone,
    neighborhood: Faker::Address.street_name,
    website: "www.#{Faker::Hipster.word}.com")
  end
end

def create_specials(num = 1, venue, passport)
  num.times do
    Special.create(name: Faker::Hipster.word,
    venue_id: venue,
    passport_id: passport)
  end
end

def create_user_passports(num = 1, user, passport)
  num.times do
    UserPassport.create(user_id: user, passport_id: passport)
  end
end

def create_groups(num = 1)
  num.times do
    create_passports(1)
    Group.create(name: Faker::Hipster.word,
                 passport_id: Passport.first.id)
  end
end

def create_yelp_venue(num = 1)
  create_venues(1)
  lv = Venue.last
  vcount = Venue.count
  num.times do
    YelpVenue.create(venue_id: Random.new.rand((lv.id-vcount+1)..(lv.id)),
                     yelp_id: "test-id",
                     rating_url: "test-rating",
                     yelp_url: "test-url",
                     review_count: 5)
  end
end

def create_visits(num = 1)
  create_venues(1)
  v = Venue.first.id
  create_users(1)
  u = User.first.id
  create_passports(1)
  p = Passport.first.id
  create_user_passports(1, u, p)
  up = UserPassport.first.id
  num.times do
    Visit.create(venue_id: v, user_passport_id: up)
  end
end
