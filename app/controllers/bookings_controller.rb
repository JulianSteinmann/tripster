class BookingsController < ApplicationController
  def create
    @booking = Booking.new
    @trip = Trip.find(params[:trip_id])
    @booking.user = current_user
    @booking.trip = @trip
    @booking.status = 'pending'
    @trip.seats -= 1 if @trip.seats.positive?
    if @booking.save
      @trip.save
      redirect_to dashboard_path
    else
      render :new
    end
  end
end
