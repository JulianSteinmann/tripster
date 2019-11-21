class ReviewsController < ApplicationController
  def new
    @trip = Trip.find(params[:trip_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @trip = Trip.find(params[:trip_id])
    @review.trip = @trip
    if @review.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def review_params
    params.require(:review).permit(:content, :stars, :trip_id)
  end

end

