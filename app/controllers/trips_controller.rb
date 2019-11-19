class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @trips = Trip.all
    if params[:origin]
      origin = params[:origin].capitalize
    end
    if params[:destination]
      destination = params[:destination].capitalize
    end
    @trips_search = Trip.where(["origin = ? and destination = ?", origin, destination])
    @trips_partial = Trip.where(["origin = ?", origin])
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
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  private

  def find_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:destination, :origin, :departure_time, :seats, :price)
  end
end
