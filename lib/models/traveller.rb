class Traveller < ActiveRecord::Base
  has_many :activities
  has_many :trips, through: :activities

  attr_reader :activity_name


  validates :name, presence: true

  def self.travellers_name
    Traveller.all.map { |traveller| traveller.name}
  end

  # def add_a_new_destination(city, country)
  #   trip = Destination.create(city: city, country: country)
  #   if trip.save
  #     puts "new trip added!"
  #   else
  #     trip.errors.messages
  #   end
  #   self.destinations << trip
  # end

  def get_cities
    self.trips.map {|trip| trip.city}.uniq
  end

  def add_new_activity(new_activity)
    new_activity = new_activity.merge({ traveller: self })
    Activity.create(new_activity)
  end

  def get_activities
    self.activities.map {|activity| activity.activity_name}.uniq
  end

  def my_posts
    self.activities.map {|activity| activity.comment }
  end

end
