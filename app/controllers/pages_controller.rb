class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @trips = Trip.all
    @my_trips = Trip.where(user_id: current_user.id)
    bookings = Booking.joins(:trip).where(user_id: current_user.id)
    @booked_trips = bookings.map(&:trip)
    @user = current_user
  end
end
