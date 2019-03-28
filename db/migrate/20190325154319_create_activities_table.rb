class CreateActivitiesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :activity_name
      t.text :comment
    end
  end
end
