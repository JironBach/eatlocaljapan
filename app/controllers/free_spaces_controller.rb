class FreeSpacesController < ApplicationController
  include AroundReservation

  before_action :set_listing, :reservation_enabled?, :set_schedule, :set_requested_time, only: [:show]

  authorize_resource :listing, class: Listing

  def show
    unless @schedule && @requested_time
      render json: {error: 'Invalid date or time'}, status: 400
    else
      if @schedule.past?
        render json: {error: 'Please select a future date'}, status: 400
      else
        render json: {spaces: @listing.free_spaces(@schedule, @requested_time)}
      end
    end
  end

private
  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_schedule
    @schedule = Time.zone.local(params[:year_id], params[:month_id], params[:day_id]) rescue nil
  end

  def set_requested_time
    @requested_time = Time.zone.local(params[:year_id], params[:month_id], params[:day_id], params[:hour_id], params[:minute_id]) rescue nil
  end
end