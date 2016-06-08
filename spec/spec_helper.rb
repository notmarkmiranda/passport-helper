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

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
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
