class ListingsController < ApplicationController
  before_action :authenticate_user?, except: [:index, :show, :search, :search_detail]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_listing_obj, only: [:publish, :unpublish]
  before_action :set_listing_related_data, only: [:show, :edit]
  before_action :check_profile, only: [:new, :create]

  authorize_resource

  # GET /listings
  # GET /listings.json
  def index
    @listings = \
      if current_user.admin?
        Listing.all.order_by_updated_at_desc
      else
        Listing.mine(current_user.id).order_by_updated_at_desc
      end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    user_id = 0
    user_id = current_user.id if user_signed_in?
    BrowsingHistory.insert_record(user_id, @listing.id)
    ListingPv.add_count(@listing.id)
    @reviews = Review.this_listing(@listing.id).joins(:reservation).merge(Reservation.review_open?).order_by_created_at_desc.page(params[:page])
    @host_info = Profile.find_by(user_id: @listing.user_id)
    @host_image = ProfileImage.find_by(user_id: @listing.user_id)
    @message = Message.new
    # @wishlists = Wishlist.mine(current_user).order_by_created_at_desc
    gon.listing = @listing
    @reservation = Reservation.new
  end

  def new
    @listing = Listing.new
  end

  def edit
    @listing.easy_translate
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.easy_translate(prefix: '(Translated by Google)', fields: [:shop_description, :location, :recommended, :visit_benefits, :visit_benefits_another])
    respond_to do |format|
      unless @listing.valid? && @listing.set_lon_lat
        flash[:notice] = I18n.t('alerts.listings.set_lon_lat.error')
        format.html { render :new }
      else
        if @listing.save
          format.html { redirect_to edit_listing_reservations_setting_path(@listing.id), notice: I18n.t('alerts.listings.save.success', model: Listing.model_name.human) }
        else
          format.html { render :new }
          format.json { render json: @listing.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    @listing.assign_attributes(listing_params)
    @listing.easy_translate(prefix: '(Translated by Google)', fields: [:shop_description, :location, :recommended, :visit_benefits, :visit_benefits_another])
    respond_to do |format|
      if @listing.save
        format.html { redirect_to edit_listing_reservations_setting_path(@listing), notice: I18n.t('alerts.listings.update.success', model: Listing.model_name.human) }
      else
        format.html { redirect_to edit_listing_path(@listing), notice: I18n.t('alerts.listings.update.failure', model: Listing.model_name.human) }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_detail
    @listings = \
      if current_user.nil?
        Listing.mine(0)
      else
        Listing.mine(current_user.id).order_by_updated_at_desc
      end
  end

  def search
    @listings = Listing.search(search_params).opened.page(params[:page]).per(10)
    @hit_count = @listings.count
    @conditions = params
    @listing = Listing.new
  end

  def publish
    return redirect_to new_profile_path unless Profile.exists?(user_id: @listing.user_id)
    respond_to do |format|
      if @listing.publish
        format.html { redirect_to listing_path(@listing), notice: I18n.t('alerts.listings.publish.success', model: Listing.model_name.human) }
      else
        format.html { redirect_to edit_listing_path(@listing), notice: I18n.t('alerts.listings.publish.failure', model: Listing.model_name.human) }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  def unpublish
    respond_to do |format|
      if @listing.unpublish
        format.html { redirect_to edit_listing_path(@listing), notice: I18n.t('alerts.listings.unpublish.success', model: Listing.model_name.human) }
      else
        format.html { redirect_to edit_listing_path(@listing), notice: I18n.t('alerts.listings.unpublish.failure', model: Listing.model_name.human) }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def check_profile
    user = User.find(listing_params[:user_id])
    redirect_to edit_profile_path, notice: I18n.t('alerts.reservation.requirement.profile.not_yet', model: Profile.model_name.human) unless user.profile&.minimum_requirement?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_listing
    @listing = Listing.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: Settings.listings.error.invalid_listing_id
  end

  def set_listing_obj
    @listing = Listing.find(params[:listing_id])
  end

  def set_listing_related_data
    @listing_image = ListingImage.find_by(listing_id: @listing.id)
    @confection = Confection.find_by(listing_id: @listing.id)
    @dress_code = DressCode.find_by(listing_id: @listing.id)
    @tool = Tool.find_by(listing_id: @listing.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def listing_params
    params \
      .fetch(:listing, {}) \
      .permit(
        :user_id, :evaluation_count, :zipcode, :location, :location_en, :longitude, :latitude, :delivery_flg, :price, :info_admin_id,
        :ave_total, :ave_accuracy, :ave_communication, :ave_cleanliness, :ave_location, :ave_check_in, :ave_cost_performance, :open,
        :description, :description_en, :title, :title_en, :capacity, :direction, :schedule, :listing_images,
        :cover_image, :cover_image_caption, :cover_video, :cover_video_caption, :smoking_id, :unit, :reservation_time_unit, :from, :to,
        :business_hours_remarks, :shop_description, :shop_description_en, :price_low, :price_high, :tel, :url, :review_url,
        :recommended, :recommended_en, :visit_benefits, :visit_benefits_en, :visit_benefits_another, :visit_benefits_another_en,
        :price_low_dinner, :price_high_dinner, :link_tabelog, :link_yelp, :link_tripadvisor, :reservation_frame, :capacity,
        listing_image_attributes: [:listing_id, :image, :order, :capacity],
        listings_shop_categories_attributes: [:id, :shop_category_id, :_destroy],
        listings_shop_services_attributes: [:id, :shop_service_id, :_destroy],
        englishes_listings_attributes: [:id, :english_id, :_destroy],
        english_messages_listings_attributes: [:id, :english_message_id, :_destroy],
        weekday_business_hours_attributes: [:id, :wday, :is_open, :start_hour, :end_hour, :lunch_break_start_hour, :lunch_break_end_hour, :_destroy],
        holiday_business_hour_attributes: [:id, :is_open, :start_hour, :end_hour, :lunch_break_start_hour, :lunch_break_end_hour, :_destroy]
      ) \
      .merge(user_id: current_user.id)
  end

  def search_params
    params \
      .require(:search) \
      .permit(
        :location, :schedule, :num_of_guest, :price, :keywords, :where, :prefectures, :shop_categories, :shop_name, :smoking_id,
        shop_categories: [], shop_services: [], englishes: []
      )
  end
end
