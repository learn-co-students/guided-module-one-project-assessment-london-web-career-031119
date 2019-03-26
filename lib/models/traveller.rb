class Traveller < ActiveRecord::Base
  has_many :activities
  has_many :destinations, through: :activities

  validates :name, presence: true

  def self.travellers_name
    Traveller.all.map { |traveller| traveller.name}
  end

  def self.average_travellers_age
    total_ages = Traveller.all.map {|traveller| traveller.age}.sum
    total_ages / (Traveller.all).length
  end

  def add_a_new_destination(city, country)
    trip = Destination.create(city: city, country: country)
    if trip.save
      puts "new trip added!"
    else
      trip.errors.messages
    end
    self.destinations << trip
  end

  def get_destinations_by_country
    self.destinations.map {|destination| destination.country}
  end

  def get_destinations_by_city
    self.destinations.map {|destination| destination.city}
  end

  def add_new_activity(activity_name, comment, rating, destination_id)
    new_activity = Activity.create(activity_name: activity_name, comment: comment,
      rating: rating, traveller_id: self, destination_id: destination_id)
        self.activities << new_activity
  end

  def get_activities
    self.activities.map {|activity| activity.activity_name}
  end

  def delete
    self.destroy
  end

end
