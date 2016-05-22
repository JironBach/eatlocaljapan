class ListingNgeventsController < ApplicationController
  before_action :authenticate_user?, except: [:show, :search]
  before_action :set_my_event, only: [:edit, :update, :destroy]
  before_action :set_listing
  authorize_resource :user_ngevent

  # GET /listings/1/ngevents.json
  def index
    @ngevents = UserNgevent.mine(current_user).where(listing_id: params[:listing_id])
  end

  # GET /listings/1/ngevents/search.json
  def search
    ngs = UserNgevent.opened
    ngs = ngs.where(listing_id: params[:listing_id])
    ngs = ngs.around_month( DateTime.parse(params[:first_day]) )
    @ng_days = ngs.map( &:consecutive_days ).flatten
  end

  def manage
    authorize! :manage, @listing
  end

  # POST /listings/1/ngevents
  # POST /listings/1/ngevents.json
  def create
    ngevent_params = listing_ngevent_params.merge(
        listing_id: params[:listing_id],
        reason: :holiday
    )
    @ngevent = UserNgevent.new( ngevent_params ).convert_end_of_day

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
    @ngevent.assign_attributes( listing_ngevent_params )
    @ngevent.convert_end_of_day

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

    def set_event
      @ngevent = UserNgevent.find(params[:id])
    end

    def set_my_event
      @ngevent = UserNgevent.where(id: params[:id], listing_id: params[:listing_id], user_id: current_user).first
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    def listing_ngevent_params
      params.require(:event).permit(
        :start, :end
      ).merge(user_id: current_user.id)
    end
end
