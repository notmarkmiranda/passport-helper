require 'csv'

desc "import boulder"
task import_boulder: [ :environment ] do
  pp = Passport.create(name: "2016 Boulder Passport",
                       city: "Boulder",
                       start: Date.new(2016, 5, 27),
                       expiration: Date.new(2016, 9, 5),
                       url: "www.thepassportprogram.com/boulder",
                       status: "active",
                       image_url: "http://aboutboulder.com/wp-content/uploads/2014/07/Screen-shot-2014-07-17-at-11.11.57-AM.png")
  puts "CREATED #{pp.name.upcase} !"
  csv = "./db/csv/2016BoulderDrinks.csv"
  CSV.foreach(csv, { :row_sep => :auto, encoding:'iso-8859-1:utf-8', headers: true, header_converters: :symbol}) do |row|
    venue = Venue.create(address: row[:venue_address],
                         phone: row[:venue_phone],
                         neighborhood: row[:venue_neighborhood],
                         website: row[:venue_website],
                         name: row[:venue_name])
    venue.specials.create(name: row[:special_offer], passport_id: pp.id)
    response = Yelp.client.search(pp.city, {term: venue.name, limit: 1}).businesses.first
    if response.id
      YelpVenue.create(venue_id:     venue.id,
                       yelp_id:      response.id,
                       rating_url:   response.rating_img_url,
                       yelp_url:     response.mobile_url,
                       review_count: response.review_count)
    end
  end
  puts "CREATED #{pp.venues.count} VENUES!"
  puts "CREATED #{pp.specials.count} SPECIALS!"
end
