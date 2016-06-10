class AddReviewCountToYelpVenue < ActiveRecord::Migration
  def change
    add_column :yelp_venues, :review_count, :integer
  end
end
