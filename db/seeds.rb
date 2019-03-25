Activity.delete_all
Traveller.delete_all
Destination.delete_all

traveller1 = Traveller.create(:name => "Laura", :age => 27)
traveller2 = Traveller.create(:name => "Mary", :age => 15)
traveller3 = Traveller.create(:name => "John", :age => 45)
traveller4 = Traveller.create(:name => "Gul", :age => 34)
traveller5 = Traveller.create(:name => "Anton", :age => 38)
traveller6 = Traveller.create(:name => "Oliver", :age => 56)
traveller7 = Traveller.create(:name => "Andreas", :age => 37)
traveller8 = Traveller.create(:name => "Amid", :age => 22)
traveller9 = Traveller.create(:name => "Jo", :age => 14)
traveller10 = Traveller.create(:name => "Juliet", :age => 25)
traveller11 = Traveller.create(:name => "Xaja", :age => 28)
traveller12 = Traveller.create(:name => "Amy", :age => 32)


dest1 = Destination.create(:city => "Montreal", :country => "Canada")
dest2 = Destination.create(:city => "Moscou", :country => "Russia")
dest3 = Destination.create(:city => "Cape Town", :country => "South Africa")
dest4 = Destination.create(:city => "Lima", :country => "Peru")
dest5 = Destination.create(:city => "NYC", :country => "NY, US")
dest6 = Destination.create(:city => "San Jose", :country => "Costa Rica")
dest7 = Destination.create(:city => "Cairo", :country => "Egypt")
dest8 = Destination.create(:city => "Roma", :country => "Italy")
dest9 = Destination.create(:city => "Marseille", :country => "France")
dest10 = Destination.create(:city => "Denali", :country => "Alaska, US")
dest11 = Destination.create(:city => "Florianopolis", :country => "Brazil")
dest12 = Destination.create(:city => "Amsterdam", :country => "The Netherlands")

hiking = Activity.create(:activity_name => "hiking", :comment => "awesome trip", :rating => 4)
photography = Activity.create(:activity_name => "photography", :comment => "great light, great people", :rating => 4)
horse_riding = Activity.create(:activity_name => "horse_riding", :comment => "amazing nature", :rating => 4)
surfing = Activity.create(:activity_name => "surfing", :comment => "good waves", :rating => 4)


traveller1.activities << hiking
dest1.activities << hiking
