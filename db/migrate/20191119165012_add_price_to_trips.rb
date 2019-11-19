class AddPriceToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :price, :integer
  end
end
