class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

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

    if @my_reviews.length > 0
      @average_review = total / @my_reviews.length
    end

    bookings = Booking.joins(:trip).where("departure_time > ? AND bookings.user_id = ?", DateTime.now, current_user.id)
    @booked_trips = bookings.map(&:trip)


    completed = Booking.joins(:trip).where("departure_time < ? AND bookings.user_id = ?", DateTime.now, current_user.id)
    @completed_trips = completed.map(&:trip)
    @user = current_user
  end
end

# Trip.where(["origin = ? and destination = ? and seats > ?", origin, destination, 0])
