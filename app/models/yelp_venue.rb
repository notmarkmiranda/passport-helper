class YelpVenue < ActiveRecord::Base
  validates :venue_id,   presence: true
  validates :yelp_id,    presence: true
  validates :rating_url, presence: true
  validates :yelp_url,   presence: true
  validates :venue_id,   uniqueness: { scope: :yelp_id}
end
