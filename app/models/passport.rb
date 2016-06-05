class Passport < ActiveRecord::Base
  has_many :user_passports
  has_many :users, through: :user_passports

  validates :name, presence: true, uniqueness: true
  validates :start, presence: true
  validates :expiration, presence: true
  validates :status, presence: true
end
