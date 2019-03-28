Activity.delete_all
Traveller.delete_all
Trip.delete_all

laura = Traveller.create(:name => "Laura")
mary = Traveller.create(:name => "Mary")
john = Traveller.create(:name => "John")
gul = Traveller.create(:name => "Gul")


montreal = Trip.create(:city => "Montreal", :country => "Canada")
moscou = Trip.create(:city => "Moscou", :country => "Russia")
cape_town = Trip.create(:city => "Cape Town", :country => "South Africa")
lima = Trip.create(:city => "Lima", :country => "Peru")
nyc = Trip.create(:city => "NYC", :country => "NY, US")

hiking = Activity.create(:activity_name => "hiking", :comment => "awesome trip", :traveller_id => laura.id, :trip_id => montreal.id)
photography = Activity.create(:activity_name => "photography", :comment => "great light, great people", :traveller_id => laura.id, :trip_id => moscou.id)
horse_riding = Activity.create(:activity_name => "horse_riding", :comment => "amazing nature", :traveller_id => laura.id, :trip_id => cape_town.id)
surfing = Activity.create(:activity_name => "surfing", :comment => "good waves", :traveller_id => laura.id, :trip_id => lima.id)
apple_picking = Activity.create(:activity_name => "hiking", :comment => "blablabla", :traveller_id => mary.id, :trip_id => nyc.id)
shopping = Activity.create(:activity_name => "hiking", :comment => "I will come back for sure", :traveller_id => mary.id, :trip_id => moscou.id)
wine_tour = Activity.create(:activity_name => "wine tour", :comment => "what a food and wine scene!!", :traveller_id => mary.id, :trip_id => montreal.id)
snow_shoewing = Activity.create(:activity_name => "snow shoewing", :comment => "Mindblowing nature", :traveller_id => mary.id, :trip_id => lima.id)
night_photography = Activity.create(:activity_name => "night_photography", :comment => "Incredible people", :traveller_id => john.id, :trip_id => cape_town.id)
fishing = Activity.create(:activity_name => "fishing", :comment => "I've seen a bear!!", :traveller_id => gul.id, :trip_id => nyc.id)
kayak = Activity.create(:activity_name => "hiking", :comment => "Gimme more of kayak there", :traveller_id => john.id, :trip_id => lima.id)
skiing = Activity.create(:activity_name => "skiing", :comment => "Skiing with the best instructors", :traveller_id => gul.id, :trip_id => montreal.id)



#
# traveller1.activities << hiking
# dest1.activities << hiking
