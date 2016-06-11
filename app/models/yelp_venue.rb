class YelpVenue < ActiveRecord::Base
  belongs_to :venue
  validates :venue_id,   presence: true
  validates :yelp_id,    presence: true
  validates :rating_url, presence: true
  validates :yelp_url,   presence: true
  validates :venue_id,   uniqueness: { scope: :yelp_id }

  def self.up_visits(user_passport)
    joins(venue: [:visits])
    .where(visits: { user_passport_id: user_passport.id})
    .pluck("yelp_id")
    .each { |tag| tag.prepend("#") }.join(", ")
  end
end
