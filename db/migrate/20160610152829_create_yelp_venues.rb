class CreateYelpVenues < ActiveRecord::Migration
  def change
    create_table :yelp_venues do |t|
      t.references :venue, index: true, foreign_key: true
      t.string :yelp_id
      t.string :rating_url
      t.string :yelp_url
    end
  end
end
