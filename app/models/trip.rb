class Trip < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookings

  validates :destination, presence: true
  validates :seats, presence: true
  validates :origin, presence: true
  validates :departure_time, presence: true
  validates :price, presence: true

  # geocoded_by :origin,
  #   latitude: :origin_latitude,
  #   longitude: :origin_longitude

  # geocoded_by :destination,
  #   latitude: :destination_latitude,
  #   longitude: :destination_longitude
  after_validation :geocode_endpoints

  def geocode_endpoints
    return unless origin_changed?

    geocoded = Geocoder.search(origin).first
    return unless geocoded

    self.origin_latitude = geocoded.latitude
    self.origin_longitude = geocoded.longitude
    return unless destination_changed?

    geocoded = Geocoder.search(destination).first
    return unless geocoded

    self.destination_latitude = geocoded.latitude
    self.destination_longitude = geocoded.longitude
  end
end
