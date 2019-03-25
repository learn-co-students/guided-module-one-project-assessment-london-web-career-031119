class Traveller < ActiveRecord::Base
  has_many :activities
  has_many :destinations, through: :activities

end
