class SettingsController < ApplicationController
  include AroundReservation

  before_action :authenticate_user?
  before_action :load_listing
  before_action :reservation_available?

  authorize_resource :listing, class: Listing, parent_action: :update

  def edit
    @listing.easy_translate
  end

  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to edit_listing_reservations_setting_path(@listing), notice: I18n.t('alerts.listings.update.success', model: Listing.model_name.human) }
      else
        format.html { redirect_to edit_listing_reservations_setting_path(@listing), notice: I18n.t('alerts.listings.update.failure', model: Listing.model_name.human) }
      end
    end
  end

private
  def load_listing
    @listing = Listing.find(params[:listing_id])
  end

  def listing_params
    params \
      .require(:listing) \
      .permit(
        :user_id, :evaluation_count, :ave_total, :ave_accuracy, :ave_communication, :ave_cleanliness, :ave_location, :ave_check_in, :ave_cost_performance, :open,
        :zipcode, :location, :location_en, :longitude, :latitude, :delivery_flg, :price, :description, :description_en, :title, :title_en, :capacity, :direction, :schedule,
        :listing_images, :cover_image, :cover_image_caption, :cover_video, :cover_video_caption, :smoking_id, :unit, :reservation_time_unit, :from, :to,
        :business_hours_remarks, :shop_description, :shop_description_en, :price_low, :price_high, :tel, :url, :review_url, :recommended, :recommended_en,
        :visit_benefits, :visit_benefits_en, :visit_benefits_another, :visit_benefits_another_en, :price_low_dinner, :price_high_dinner,
        :link_tabelog, :link_yelp, :link_tripadvisor, :reservation_frame, :capacity,
        listing_image_attributes: [:listing_id, :image, :order, :capacity]
      )
  end
end