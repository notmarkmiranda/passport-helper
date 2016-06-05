require 'rails_helper'

describe UserPassport, 'validations' do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:passport_id) }

  xit { should validate_uniqueness_of(:user_id).scoped_to(:passport_id) }
end
