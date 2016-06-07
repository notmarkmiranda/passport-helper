require 'csv'

desc "import denver fika"
task import_denver_fika: [ :environment ] do
  pp = Passport.create(name: "2016 Denver Fika Passport",
                       start: Date.new(2016, 4, 1),
                       expiration: Date.new(2016, 10, 1),
                       status: "active")
  puts "CREATED #{pp.name.upcase} !"
  csv = "./db/csv/2016DenverFika.csv"
  CSV.foreach(csv, { :row_sep => :auto, encoding:'iso-8859-1:utf-8', headers: true, header_converters: :symbol }) do |row|
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
