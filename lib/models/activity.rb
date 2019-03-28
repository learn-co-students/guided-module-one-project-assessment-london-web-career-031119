class Activity < ActiveRecord::Base
  belongs_to :traveller
  belongs_to :trip



  def self.activities_name
    self.all.map {|activity| activity.activity_name}
  end

  def self.most_popular_activity
    activities_name.group_by(&:to_s).values.max_by(&:size).try(:first)
  end


end
