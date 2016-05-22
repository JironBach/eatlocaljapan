class ListingImagesController < ApplicationController
  before_action :authenticate_user?
  before_action :set_listing_image, only: [:update, :destroy]
  before_action :set_listing
  authorize_resource

  def manage
    authorize! :manage, @listing
    listing_images = ListingImage.records(params[:listing_id])
    if listing_images.size.zero?
      @listing_image = ListingImage.new
      return
    else
      @listing_image = listing_images[0]
      return
    end
  end

  def create
    @listing_image = ListingImage.new(listing_image_params)
    count = ListingImage.where(listing_id: @listing.id).size
    @listing_image.order_num = count
    if @listing_image.save
      redirect_to manage_listing_listing_images_path(@listing.id), notice: I18n.t('alerts.listing_images.save.success', model: ListingImage.model_name.human)
      #render json: { success: true, status: :created, location: @listing_image }
    else
      redirect_to manage_listing_listing_images_path(@listing.id), notice: I18n.t('alerts.listing_images.save.failure', model: ListingImage.model_name.human)
      #render json: { success: false, errors: @listing_image.errors, status: :unprocessable_entity }
    end
  end

  def update
    if @listing_image.update(listing_image_params)
      redirect_to manage_listing_listing_images_path(@listing.id), notice: I18n.t('alerts.listing_images.save.success', model: ListingImage.model_name.human)
      #render json: { success: true, status: :ok, location: @listing_image, notice: Settings.listing_images.save.success }
    else
      redirect_to manage_listing_listing_images_path(@listing.id), notice: I18n.t('alerts.listing_images.save.failure', model: ListingImage.model_name.human)
      #render json: { success: false, errors: @listing_image.errors, status: :unprocessable_entity, notice: Settings.listing_images.save.failure }
    end
  end

  def destroy
    @listing_image.destroy
    respond_to do |format|
      format.html { redirect_to listing_images_url, notice: 'ListingImage was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_listing_image
      @listing_image = ListingImage.find(params[:id])
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    def listing_image_params
      params.require(:listing_image).permit(:listing_id, :image, :caption)
        .merge(listing_id: @listing.id)
    end

end
