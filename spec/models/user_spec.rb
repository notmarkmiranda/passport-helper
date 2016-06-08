require 'rails_helper'
require 'ostruct'

describe User, "validations" do

	it { should validate_presence_of(:provider) }
	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }

	it { should have_many(:user_passports) }
	it { should have_many(:passports).through(:user_passports)}

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

	it "user#finish_registration updates user attributes" do
		user = User.create(email: "markmiranda51@gmail.com", password: "password", provider: "email")
		expect(user.image_url).to be_nil
		expect(user.name).to be_nil
		updated_params = { image_url: "https://case.edu/medicine/admissions/media/school-of-medicine/admissions/classprofile.png",
		                   name: "Mark Miranda" }
		user.finish_registration(updated_params)
		expect(user.image_url).to_not be_nil
		expect(user.name).to_not be_nil
	end

end

describe User, "#passport_count" do

		before do
			create_users(2)
			create_passports(3)
			@user = User.first
			passport1 = Passport.first
			passport3 = Passport.last
			UserPassport.create(passport_id: passport1.id, user_id: @user.id)
			UserPassport.create(passport_id: passport3.id, user_id: @user.id)
		end

		it "can count a users passports" do
			expect(@user.passport_count).to eq 2
		end

end
