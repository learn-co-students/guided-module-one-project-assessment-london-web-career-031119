class CreateTripsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :city
      t.string :country
    end
  end
end
