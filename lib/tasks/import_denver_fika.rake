require 'csv'

desc "import denver fika"
task import_denver_fika: [ :environment ] do
  pp = Passport.create(name: "2016 Denver Fika Passport",
                       city: "Denver",
                       start: Date.new(2016, 4, 1),
                       expiration: Date.new(2016, 10, 1),
                       url: "www.thepassportprogram.com/fika/",
                       status: "active",
                       image_url: "http://static1.squarespace.com/static/52b0be8ae4b04b55eedc7e84/56f02b7f9f726647a0568bfa/56f02b8a555986f39d3b046f/1458580373442/FIKA_1239.jpg?format=1500w")
  puts "CREATED #{pp.name.upcase} !"
  csv = "./db/csv/2016DenverFika.csv"
  CSV.foreach(csv, { :row_sep => :auto, encoding:'iso-8859-1:utf-8', headers: true, header_converters: :symbol }) do |row|
    venue = Venue.create_with(address: row[:venue_address],
                              phone: row[:venue_phone],
                              neighborhood: row[:venue_neighborhood],
                              website: row[:venue_website])
                              .find_or_create_by(name: row[:venue_name])
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
