class ClosedDaysController < ApplicationController
  include AroundReservation

  before_action :set_listing, :reservation_enabled?, :set_first_day, only: [:show]

  def show
    render json: @listing.closed_days(@first_day)
  end

private
  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_first_day
    @first_day = Time.zone.local(params[:year_id], params[:month_id]) rescue nil
  end
end