class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @trips = Trip.all
    @trips_search = Trip.where(["origin = ? and destination = ?", params[:origin], params[:destination]])
    @trips_partial = Trip.where(["origin = ?", params[:origin]])
  end

  def show
    find_trip
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    if @trip.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def find_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:destination, :origin, :departure_time, :seats)
  end
end
