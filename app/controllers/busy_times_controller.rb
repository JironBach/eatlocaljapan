class BusyTimesController < ApplicationController
  include AroundReservation

  before_action :set_listing, :reservation_enabled?, :set_schedule, only: [:show]

  authorize_resource :listing, class: Listing

  def show
    busy_times, on_time = \
      if @schedule
        [
          @listing.busy_times(@schedule).map { |times| times.map { |time| I18n.l(time, format: :hour) } },
          @listing.on_time(@schedule).map { |time| I18n.l(time, format: :hour) }
        ]
      end
    unless @schedule
      render json: {error: 'Invalid date'}, status: 400
    else
      render json: {on_time: on_time, times: busy_times}
    end
  end

private
  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_schedule
    @schedule = Time.zone.local(params[:year_id], params[:month_id], params[:day_id]) rescue nil
  end
end