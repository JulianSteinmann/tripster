class Trip < ApplicationRecord
  belongs_to :user

  validates :destination, presence: true
  validates :seats, presence: true
  validates :origin, presence: true
  validates :departure_time, presence: true

end
