require 'simplecov'
SimpleCov.start("rails")
require 'database_cleaner'
require 'omniauth-twitter'
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
OmniAuth.config.add_mock(auth_hash)

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
