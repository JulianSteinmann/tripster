class BookingsController < ApplicationController

  def create
    @booking = Booking.new
    @trip = Trip.find(params[:trip_id])
    @booking.user = current_user
    @booking.trip = @trip
    @booking.status = 'pending'
    if @booking.save
      redirect_to root_path
    else
      render :new
    end
  end

end
