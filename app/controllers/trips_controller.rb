class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @trips = Trip.where("seats > ?", 0)
    if params[:origin].present?
      origin = params[:origin].capitalize
      @trips = @trips.where(origin: origin)
    end
    if params[:destination].present?
      destination = params[:destination].capitalize
      @trips = @trips.where(destination: destination)
    end
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
