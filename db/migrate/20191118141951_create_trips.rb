class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.references :user, foreign_key: true
      t.string :destination
      t.string :origin
      t.date :departure_time
      t.integer :seats

      t.timestamps
    end
  end
end
