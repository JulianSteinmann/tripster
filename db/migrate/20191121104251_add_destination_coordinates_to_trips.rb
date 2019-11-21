class AddDestinationCoordinatesToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :destination_latitude, :float
    add_column :trips, :destination_longitude, :float
  end
end
