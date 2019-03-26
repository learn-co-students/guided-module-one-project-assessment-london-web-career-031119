Booking.destroy_all
User.destroy_all
Restaurant.destroy_all

#Users
gio = User.create(name: 'Gio D.')
manon = User.create(name: 'Manon J.')
jack = User.create(name: 'Jack Morr.')
guy = User.create(name: 'Guy J.')
nico = User.create(name: 'Nicolas S.')
vasile = User.create(name: 'Vasile V.')

#Restaurants
r1 = Restaurant.create(name: "Blue Mood")
r2 = Restaurant.create(name: "Italo Restaurant")
r3 = Restaurant.create(name: "Nando's")
r4 = Restaurant.create(name: "KFC")
r5 = Restaurant.create(name: "Quadra Restaurant")
r6 = Restaurant.create(name: "Pure Chinese")
r7 = Restaurant.create(name: "Eat Tokyo")

#Bookings
Booking.create([
  {user_id: gio.id, restaurant_id: r1.id},
  {user_id: gio.id, restaurant_id: r4.id},
  {user_id: manon.id, restaurant_id: r2.id},
  {user_id: manon.id, restaurant_id: r1.id},
  {user_id: jack.id, restaurant_id: r3.id},
  {user_id: jack.id, restaurant_id: r7.id},
  {user_id: jack.id, restaurant_id: r7.id},
  {user_id: jack.id, restaurant_id: r6.id},
  {user_id: guy.id, restaurant_id: r1.id},
  {user_id: guy.id, restaurant_id: r4.id},
  {user_id: nico.id, restaurant_id: r5.id},
  {user_id: nico.id, restaurant_id: r2.id},
  {user_id: vasile.id, restaurant_id: r6.id},
  {user_id: vasile.id, restaurant_id: r5.id}
])
