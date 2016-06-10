class YelpService
  def self.connection(yelp_id)
    Yelp.client.business(yelp_id)
  end
end
