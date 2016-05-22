class ConfectionsController < ApplicationController
  before_action :authenticate_user?
  before_action :set_confection, only: [:update, :destroy]
  before_action :set_listing
  authorize_resource

  def manage
    authorize! :manage, @listing
    confections = Confection.records(params[:listing_id])
    if confections.size.zero?
      @confection = Confection.new
      return
    else
      @confection = confections[0]
    end
  end

  def create
    @confection = Confection.new(confection_params)
    if @confection.save
      redirect_to manage_listing_confections_path(@listing.id), notice: I18n.t('alerts.confections.save.success', model: Confection.model_name.human)
      #render json: { success: true, status: :created, location: @confection }
    else
      redirect_to manage_listing_confections_path(@listing.id), notice: I18n.t('alerts.confections.save.failure', model: Confection.model_name.human)
      #render json: { success: false, errors: @confection.errors, status: :unprocessable_entity }
    end
  end

  def update
    if @confection.update(confection_params)
      redirect_to manage_listing_confections_path(@listing.id), notice: I18n.t('alerts.confections.save.success', model: Confection.model_name.human)
      #render json: { success: true, status: :created, location: @confection }
    else
      redirect_to manage_listing_confections_path(@listing.id), notice: I18n.t('alerts.confections.save.failure', model: Confection.model_name.human)
      #render json: { success: true, errors: @confection.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @confection.destroy
    respond_to do |format|
      format.html { redirect_to confections_url, notice: 'Confection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_confection
      @confection = Confection.find(params[:id])
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    def confection_params
      params.require(:confection).permit(:listing_id, :name, :image, :url)
        .merge(listing_id: @listing.id)
    end
end
