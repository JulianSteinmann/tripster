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

    filter
    get_date

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
      @trips = Trip.where(["origin = ? and seats > ?", origin, 0])
    else
      @trips = Trip.where(["origin = ? and destination = ? and seats > ?", origin, destination, 0])
    end
  end

  def get_date
    if params[:departure_time]
      date = params[:departure_time].values.first(3).join('')
      time = "T#{params[:departure_time].values.last(2).join('')}"
      datetime = date + time
      DateTime.parse(datetime)
      @datetime = DateTime.parse(datetime)
      @trips = @trips.where("departure_time >= ?", @datetime)
    end
  end
end


# Wed, 20 Nov 2019 14:36:00 +0000
