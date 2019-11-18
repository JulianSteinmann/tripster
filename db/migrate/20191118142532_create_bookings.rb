class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :trip, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
