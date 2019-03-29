require 'pry'



class Trip < ActiveRecord::Base
  has_many :activities
  has_many :travellers, through: :activities

  # Checks if the user enters a city and a country
  validates :city, presence: true
  validates :country, presence: true

  def self.trips
    Trip.all.map {|trip| trip.city}.uniq
  end

  def self.all_cities
    self.all.map {|trip| trip.city }
  end

end
