require 'csv'

desc "import denver"
task import_denver: [ :environment ] do
  # require 'pry'; binding.pry
  pp = Passport.create(name: "2016 Denver Passport",
                       start: Date.new(2016, 5, 27),
                       expiration: Date.new(2016, 9, 5),
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
  puts "CREATED #{Venue.count} VENUES!"
  puts "CREEATED #{Special.count} SPECIALS!"
end

# Venue Name,Venue Address,Venue Phone,Venue Neighborhood,Venue Website,2for1 Offer
