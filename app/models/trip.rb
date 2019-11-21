class Trip < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :destination, presence: true
  validates :seats, presence: true
  validates :origin, presence: true
  validates :departure_time, presence: true
  validates :price, presence: true
end
