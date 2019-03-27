class Activity < ActiveRecord::Base
  belongs_to :traveller
  belongs_to :trip
end
