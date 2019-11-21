class AddCoordinatesToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :origin_latitude, :float
    add_column :trips, :origin_longitude, :float
  end
end
