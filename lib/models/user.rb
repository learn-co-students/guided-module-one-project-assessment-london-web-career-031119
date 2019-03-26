class User < ActiveRecord::Base
  has_many :bookings
  has_many :restaurants, through: :bookings

  validates :name, presence: true
end
