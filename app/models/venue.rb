class Venue < ActiveRecord::Base
  has_one :yelp_venue
  has_many :specials
  has_many :passports, through: :specials
  has_many :visits
  has_many :user_passports, through: :visits
  validates :address, presence: true
  validates :name, presence: true, uniqueness: { scope: :address }
  validates :neighborhood, presence: true

  def passport_specials(passport)
    specials.find_by(passport_id: passport.id).name
  end

  def ratings
    yelp_venue.rating_url
  end

  def review_number
    yelp_venue.review_count
  end

  def yurl
    yelp_venue.yelp_url
  end

  def y_id
    yelp_venue.yelp_id
  end

end
