require 'csv'

desc "import foco"
task import_foco: [ :environment ] do
  pp = Passport.create(name: "2016 Fort Collins Passport",
                       city: "Fort Collins",
                       start: Date.new(2016, 5, 27),
                       expiration: Date.new(2016, 9, 5),
                       url: "www.thepassportprogram.com/fort-collins",
                       status: "active",
                       image_url: "http://static1.squarespace.com/static/52b0be8ae4b04b55eedc7e84/5735f654f699bbae5ebc21b7/5735f69662cd94f8456ee798/1463154342836/_MG_2090.JPG?format=1000w")
  puts "CREATED #{pp.name.upcase} !"
  csv = "./db/csv/2016FocoDrinks.csv"
  CSV.foreach(csv, { :row_sep => :auto, encoding:'iso-8859-1:utf-8', headers: true, header_converters: :symbol}) do |row|
    venue = Venue.create(address: row[:venue_address],
                         phone: row[:venue_phone],
                         neighborhood: row[:venue_neighborhood],
                         website: row[:venue_website],
                         name: row[:venue_name])
    venue.specials.create(name: row[:special_offer], passport_id: pp.id)
    response = Yelp.client.search(pp.city, {term: venue.name, limit: 1}).businesses.first
    if response.id
      YelpVenue.create!(venue_id:     venue.id,
                        yelp_id:      response.id,
                        rating_url:   response.rating_img_url,
                        yelp_url:     response.mobile_url,
                        review_count: response.review_count)
    end
  end
  puts "CREATED #{pp.venues.count} VENUES!"
  puts "CREATED #{pp.specials.count} SPECIALS!"
end
