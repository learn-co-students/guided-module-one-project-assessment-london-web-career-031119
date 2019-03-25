class AddTravellerToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :traveller_id, :integer

  end
end
