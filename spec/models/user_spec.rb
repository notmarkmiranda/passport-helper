require 'rails_helper'
require 'ostruct'

describe User, "validations" do

	it { should validate_presence_of(:provider) }
	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }

end

describe User, "using omniauth" do

	before do
		info_hash = { email: "markmiranda51@gmail.com",
		name: "Mark Miranda",
		image: "http://thesocialmediamonthly.com/wp-content/uploads/2015/08/photo.png",
		urls: "http://www.facebook.com/markmiranda51"}
		info = OpenStruct.new(info_hash)
		ah = { provider: "facebook",
	 				 info: info }
		@auth_hash = OpenStruct.new(ah)
	end

	it "creates a user from omniauth" do
		expect{ User.from_omniauth(@auth_hash) }.to change{ User.all.size }.from(0).to(1)
	end

	it "finds an existing user from omniauth" do
		User.from_omniauth(@auth_hash)
		expect{ User.from_omniauth(@auth_hash) }.not_to change{ User.all.size }
	end

end

describe User, "using email" do

	it "creates a user from email" do
		expect{ create_users(1) }.to change{ User.all.size }.from(0).to(1)
	end
	
	it "returns an error if email already exists" do
		create_users(1)
		user = User.first
		expect(User.create(email: user.email,
 								  provider: user.provider,
									name: user.name,
									password: user.password)).to_not be_persisted

	end

end
