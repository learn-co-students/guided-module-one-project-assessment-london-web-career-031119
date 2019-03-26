Activity.delete_all
Traveller.delete_all
Destination.delete_all

traveller1 = Traveller.create(:name => "Laura", :age => 27)
traveller2 = Traveller.create(:name => "Mary", :age => 15)
traveller3 = Traveller.create(:name => "John", :age => 45)
traveller4 = Traveller.create(:name => "Gul", :age => 34)


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

hiking = Activity.create(:activity_name => "hiking", :comment => "awesome trip", :rating => 4, :traveller_id => traveller1.id, :destination_id => dest1.id)
photography = Activity.create(:activity_name => "photography", :comment => "great light, great people", :rating => 4, :traveller_id => traveller1.id, :destination_id => dest2.id)
horse_riding = Activity.create(:activity_name => "horse_riding", :comment => "amazing nature", :rating => 3, :traveller_id => traveller1.id, :destination_id => dest3.id)
surfing = Activity.create(:activity_name => "surfing", :comment => "good waves", :rating => 4, :traveller_id => traveller1.id, :destination_id => dest4.id)
apple_picking = Activity.create(:activity_name => "apple picking", :comment => "blablabla", :rating => 3, :traveller_id => traveller2.id, :destination_id => dest5.id)
shopping = Activity.create(:activity_name => "shopping", :comment => "I will come back for sure", :rating => 2, :traveller_id => traveller2.id, :destination_id => dest6.id)
wine_tour = Activity.create(:activity_name => "wine tour", :comment => "what a food and wine scene!!", :rating => 3, :traveller_id => traveller2.id, :destination_id => dest7.id)
snow_shoewing = Activity.create(:activity_name => "snow shoewing", :comment => "Mindblowing nature", :rating => 5, :traveller_id => traveller2.id, :destination_id => dest8.id)
night_photography = Activity.create(:activity_name => "night_photography", :comment => "Incredible people", :rating => 5, :traveller_id => traveller3.id, :destination_id => dest9.id)
fishing = Activity.create(:activity_name => "fishing", :comment => "I've seen a bear!!", :rating => 1, :traveller_id => traveller3.id, :destination_id => dest10.id)
kayak = Activity.create(:activity_name => " kayak", :comment => "Gimme more of kayak there", :rating => 4, :traveller_id => traveller4.id, :destination_id => dest11.id)
skiing = Activity.create(:activity_name => "skiing", :comment => "Skiing with the best instructors", :rating => 3, :traveller_id => traveller4.id, :destination_id => dest12.id)



#
# traveller1.activities << hiking
# dest1.activities << hiking
