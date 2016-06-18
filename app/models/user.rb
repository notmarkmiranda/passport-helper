class User < ActiveRecord::Base

  has_secure_password
  validates :password, length: { minimum: 8 }, on: :create

  has_many :memberships
  has_many :groups, through: :memberships

  has_many :user_passports
  has_many :passports, through: :user_passports

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :provider, presence: true

  enum role: ["default", "admin"]

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(email: auth_hash['info']['email'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.image_url = auth_hash['info']['image']
    user.uid = auth_hash['uid']
    user.password = SecureRandom.hex(9)
    user.save!
    
    user
  end

  def passport_count
    passports.count
  end

  def group_count
    groups.count
  end

  def update_profile(user_params)
    update(user_params)
  end

  def group_member?(group)
    groups.include?(group)
  end

  def has_passport?(passport)
    passports.include?(passport)
  end

  def truncated_name
    new_name = []
    parts = name.split
    new_name << parts.shift
    if parts.empty?
      return new_name.first
    else
      parts.each do |n|
        new_name << n[0]
      end
    end
    new_name.join(" ")
  end

  def self.average_passports
    (UserPassport.all.count.to_f / User.all.count).round(2)
  end

end
