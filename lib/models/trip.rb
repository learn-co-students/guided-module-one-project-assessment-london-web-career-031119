require 'json'
require 'rest-client'


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

  def get_countries_data
    url = "https://www.googleapis.com/books/v1/volumes?q=#{search_term}"

  end




end
