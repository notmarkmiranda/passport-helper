class User < ActiveRecord::Base

  has_secure_password
  validates :password, length: { minimum: 8 }, on: :create

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :provider, presence: true

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(email: auth_hash['info']['email'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.image_url = auth_hash['info']['image']
    user.url = auth_hash['info']['urls'][user.provider.capitalize]
    user.uid = auth_hash['uid']
    user.password = SecureRandom.hex(9)
    user.save!
    user
  end

  def finish_registration(incoming_params)
    update(incoming_params)
  end

end
