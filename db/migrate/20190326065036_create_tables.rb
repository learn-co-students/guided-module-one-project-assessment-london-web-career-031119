class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    create_table :restaurants do |t|
      t.string :name
      t.timestamps
    end
    #when iut belongs_to it needs to have reference like id
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.timestamps
    end
  end
end
