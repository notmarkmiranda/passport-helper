require 'rails_helper'
require 'ostruct'

describe User do
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

	it "creates a user" do
		# expect(User.all.size).to eq 0
		expect{User.from_omniauth(@auth_hash)}.to change{User.all.size}.from(0).to(1)
		# expect(User.all.size).to eq 1
	end

	it "creates a user" do
		User.from_omniauth(@auth_hash)
		expect{User.from_omniauth(@auth_hash)}.not_to change{User.all.size}
	end
end
