require 'csv'

desc "import denver"
task import_denver: [ :environment ] do
  pp = Passport.create(name: "2016 Denver Passport",
                       city: "Denver",
                       start: Date.new(2016, 5, 27),
                       expiration: Date.new(2016, 9, 5),
                       url: "www.thepassportprogram.com/denver",
                       status: "active")
  puts "CREATED #{pp.name.upcase} !"
  csv = "./db/csv/2016DenverDrinks.csv"
  CSV.foreach(csv, { :row_sep => :auto, encoding:'iso-8859-1:utf-8', headers: true, header_converters: :symbol}) do |row|
    venue = Venue.create_with(address: row[:venue_address],
                              phone: row[:venue_phone],
                              neighborhood: row[:venue_neighborhood],
                              website: row[:venue_website])
                              .find_or_create_by(name: row[:venue_name])
    venue.specials.create(name: row[:special_offer], passport_id: pp.id)
  end
  puts "CREATED #{pp.venues.count} VENUES!"
  puts "CREATED #{pp.specials.count} SPECIALS!"
end
