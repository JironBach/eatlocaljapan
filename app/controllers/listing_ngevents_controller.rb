class ListingNgeventsController < ApplicationController
  include AroundReservation

  before_action :authenticate_user?, except: [:show, :search]
  before_action :set_listing
  before_action :reservation_enabled?
  before_action :set_my_events, only: [:index]
  before_action :set_new_event, only: [:create]
  before_action :set_my_event, only: [:edit, :update, :destroy]
  authorize_resource :ngevent, class: UserNgevent, parent_action: :update
  skip_authorize_resource only: [:manage]

  # GET /listings/1/ngevents.json
  def index
  end

  # GET /listings/1/ngevents/search.json
  def search
    @ng_days = @listing.listing_ngevents.around_month(Time.zone.parse(params[:first_day])).flat_map(&:consecutive_days)
  end

  def manage
    start_default = Time.zone.local((now = Time.zone.now).year, now.month, now.day, 12, 0, 0)
    @ngevent = @listing.listing_ngevents.build(user_id: current_user, reason: :temporary_closed, start: start_default, end: start_default.since(1.hour))
    authorize! :manage, @listing
  end

  # POST /listings/1/ngevents
  # POST /listings/1/ngevents.json
  def create
    respond_to do |format|
      if @ngevent.save
        format.json { render json: {}, status: :created }
      else
        format.json { render json: @ngevent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ngevents/1
  # PATCH/PUT /ngevents/1.json
  def update
    @ngevent.assign_attributes(listing_ngevent_params)
    @ngevent.convert_end_of_day if @ngevent.holiday?

    respond_to do |format|
      if @ngevent.save
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: @ngevent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ngevents/1
  # DELETE /ngevents/1.json
  def destroy
    respond_to do |format|
      if @ngevent.destroy
        format.json { render json: {}, status: :ok }
      else
        format.json { render json: @ngevent.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def set_listing
    @listing = Listing.find(params[:listing_id])
  end

  def set_event
    @ngevent = @listing.listing_ngevents.find(params[:id])
  end

  def set_my_events
    @ngevents = @listing.listing_ngevents.mine(current_user)
  end

  def set_new_event
    @ngevent = @listing.listing_ngevents.build(user: current_user, **listing_ngevent_params.symbolize_keys).tap { |ngevent| ngevent.holiday? && ngevent.convert_end_of_day }
  end

  def set_my_event
    @ngevent = @listing.listing_ngevents.mine(current_user).find(params[:id]) rescue nil
  end

  def listing_ngevent_params
    params.fetch(:event, {}).permit(:reason, :start, :end)
  end
end
