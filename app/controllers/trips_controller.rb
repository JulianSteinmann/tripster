class TripsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    find_user
    @trips = Trip.where("seats > ? and departure_time > ?", 0, DateTime.now)

    filter

  end

  def show
    find_trip

    find_user
    find_user_show
    @markers = []
    @markers <<
    {
      lat: @trip.origin_latitude,
      lng: @trip.origin_longitude,
      infoWindow: @trip.origin.capitalize
    }

    @markers <<
    {
      lat: @trip.destination_latitude,
      lng: @trip.destination_longitude,
      infoWindow: @trip.destination.capitalize
    }

    @driver_reviews = @trip.user.reviews
    total = 0

    if @driver_reviews.length > 0
      @driver_reviews.each do |review|
        total += review.stars
      end

      @average_review = total / @driver_reviews.length
    end
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

  def filter
    if params[:origin]
      origin = params[:origin].capitalize
    end
    if params[:destination]
      destination = params[:destination].capitalize
    end
    if params[:origin] == "" && params[:destination] == "" || params[:origin].nil? && params[:destination].nil?
      @trips = @trips
    elsif params[:origin] && params[:destination] == "" || params[:destination].nil?
      @trips = Trip.where(["origin = ? and seats > ? and departure_time > ?", origin, 0, DateTime.now])
    else
      @trips = Trip.where(["origin = ? and destination = ? and seats > ? and departure_time > ?", origin, destination, 0, DateTime.now])
    end
  end

  def find_user_show
    @user_show = User.find(Trip.find(params[:id]).user_id)
  end

  def find_user
    @user = current_user
  end
end
