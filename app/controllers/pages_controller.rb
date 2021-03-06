class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  before_action :find_user

  def home
  end

  def dashboard
    # @trips = Trip.all
    @my_trips = Trip.where(user_id: current_user.id)

    @my_reviews = current_user.reviews

    total = 0

    @my_reviews.each do |review|
      total += review.stars
    end

    @average_review = total / @my_reviews.length unless @my_reviews.empty?

    bookings = Booking.joins(:trip).where("departure_time > ? AND bookings.user_id = ?", DateTime.now, current_user.id)
    @booked_trips = bookings.map(&:trip)

    completed = Booking.joins(:trip).where("departure_time < ? AND bookings.user_id = ?", DateTime.now, current_user.id)
    @completed_trips = completed.map(&:trip)
  end

  private

  def find_user
    @user = current_user
  end
end

# Trip.where(["origin = ? and destination = ? and seats > ?", origin, destination, 0])
