class Passport < ActiveRecord::Base
  include Formatter

  has_many :groups, dependent: :destroy
  has_many :user_passports
  has_many :users, through: :user_passports
  has_many :specials, dependent: :destroy
  has_many :venues, through: :specials

  validates :name, presence: true, uniqueness: true
  validates :start, presence: true
  validates :expiration, presence: true
  validates :status, presence: true

  def self.active_passports
    where(status: "active")
  end

  def passport_images(size)
    if image_url
      image_url
    else
      "http://placehold.it/#{size}"
    end
  end

  def self.inactive_passports
    where.not(status: "active")
  end

end
