class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @trips = Trip.all
  end

  def show
    find_trip
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
  end

  private

  def find_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :permit)
  end
end
