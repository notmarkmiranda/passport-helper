require 'rails_helper'

describe UserPassport, 'validations' do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:passport_id) }

end

describe UserPassport, '#lookup' do
  before do
    create_users(1)
    create_passports(1)
    @user = User.first
    @passport = Passport.first
    create_user_passports(1, @user.id, @passport.id)
    @up = UserPassport.first
  end

  it "does something" do
    expect(UserPassport.lookup(@user, @passport)).to eq @up.id
  end
end
