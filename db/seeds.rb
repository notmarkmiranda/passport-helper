# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def r_year
  Random.new.rand(2000...2015)
end

def r_month
  Random.new.rand(1..12)
end

def r_day
  Random.new.rand(1..28)
end

10.times do
  Group.create(name: Faker::Hipster.word,
               created_at: Date.new(r_year, r_month, r_day))
end
puts "CREATED #{Group.count} GROUPS!"
