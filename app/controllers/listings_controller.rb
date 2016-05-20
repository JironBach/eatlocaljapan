class ListingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :set_listing_obj, only: [:publish, :unpublish]
  before_action :set_listing_related_data, only: [:show, :edit]
  authorize_resource

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.mine(current_user.id).order_by_updated_at_desc
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
    #@wishlists = Wishlist.mine(current_user).order_by_created_at_desc
    gon.listing = @listing
    @reservation = Reservation.new
  end

  def new
    @listing = Listing.new
  end

  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    if @listing.valid?
      @listing.save!
      # 緯度・経度
      @listing.set_lon_lat
      # カテゴリー
      unless params[:shop_categories].nil?
        @listing.shop_categories = []
        params[:shop_categories].each do |sc|
          unless sc.blank?
            shop_category = ShopCategory.find(sc.to_i)
            @listing.shop_categories << shop_category
          end
        end
      end
      # サービス
      unless params[:shop_services].nil?
        @listing.shop_services = []
        params[:shop_services].each do |ss|
          unless ss.blank?
            shop_service = ShopService.find(ss.to_i)
            @listing.shop_services << shop_service
          end
        end
      end
      # 英語セット
      unless params[:englishes].nil?
        @listing.englishes = []
        params[:englishes].each do |e|
          unless e.blank?
            english = English.find(e.to_i)
            @listing.englishes << english
          end
        end
      end
      @listing.smoking_id = params[:smoking_id][0]
      @listing.business_hours = []
      7.times do |wday|
        is_open = params[:is_open][wday.to_s].include?('1')
        start_hour = DateTime.parse("#{params[:start_hour][wday.to_s]['(1i)']}-#{params[:start_hour][wday.to_s]['(2i)']}-#{params[:start_hour][wday.to_s]['(3i)']} #{params[:start_hour][wday.to_s]['(4i)']}: #{params[:start_hour][wday.to_s]['(5i)']}: 0") unless params[:start_hour][wday.to_s]['(3i)'].blank?
        end_hour = DateTime.parse("#{params[:end_hour][wday.to_s]['(1i)']}-#{params[:end_hour][wday.to_s]['(2i)']}-#{params[:end_hour][wday.to_s]['(3i)']} #{params[:end_hour][wday.to_s]['(4i)']}: #{params[:end_hour][wday.to_s]['(5i)']}: 0") unless params[:end_hour][wday.to_s]['(3i)'].blank?
        business_hour = BusinessHour.new(wday: wday, is_open: is_open, start_hour: start_hour, end_hour: end_hour)
        @listing.business_hours << business_hour
      end
      unless params[:english_messages].nil?
        @listing.english_messages = []
        params[:english_messages].each do |em|
          unless em.blank?
            english_message = EnglishMessage.find(em.to_i)
            @listing.english_messages << english_message
          end
        end
      end
      @listing.info_admin_id = params[:info_admin_id][0] unless params[:info_admin_id].nil?
      # 保存
      @listing.save!
      respond_to do |format|
        if @listing.save
          format.html { redirect_to manage_listing_listing_images_path(@listing.id), notice: I18n.t('alerts.listings.save.success', model: Listing.model_name.human) }
        else
          format.html { render :new }
          format.json { render json: @listing.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:notice] = I18n.t('alerts.listings.set_lon_lat.error')
      return render :new#, notice: I18n.t('alerts.listings.set_lon_lat.error')
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    @listing = Listing.find(params[:id])
    @listing.update_attributes(listing_params)
    @listing.description_en = EasyTranslate.translate(@listing.description, to: :en) if @listing.description_en.blank?
    @listing.shop_description_en = EasyTranslate.translate(@listing.shop_description, to: :en) if @listing.shop_description_en.blank?
    @listing.description_en = EasyTranslate.translate(@listing.description, to: :en) if @listing.description_en.blank?
    @listing.location_en = EasyTranslate.translate(@listing.location, to: :en) if @listing.location_en.blank?
    @listing.recommended_en = EasyTranslate.translate(@listing.recommended, to: :en) if @listing.recommended_en.blank?
    @listing.visit_benefits_en = EasyTranslate.translate(@listing.visit_benefits, to: :en) if @listing.visit_benefits_en.blank?
    @listing.visit_benefits_another_en = EasyTranslate.translate(@listing.visit_benefits_another, to: :en) if @listing.visit_benefits_another_en.blank?
    logger.debug("JironBach:@listing=#{@listing.inspect}")
    if @listing.valid?
      @listing.save!
      # 緯度・経度
      @listing.set_lon_lat
      # カテゴリー
      unless params[:shop_categories].nil?
        @listing.shop_categories = []
        params[:shop_categories].each do |sc|
          unless sc.blank?
            shop_category = ShopCategory.find(sc.to_i)
            @listing.shop_categories << shop_category
          end
        end
      end
      # サービス
      unless params[:shop_services].nil?
        @listing.shop_services = []
        params[:shop_services].each do |ss|
          unless ss.blank?
            shop_service = ShopService.find(ss.to_i)
            @listing.shop_services << shop_service
          end
        end
      end
      @listing.smoking_id = params[:smoking_id][0]
      # 英語セット
      unless params[:englishes].nil?
        @listing.englishes = []
        params[:englishes].each do |e|
          unless e.blank?
            english = English.find(e.to_i)
            @listing.englishes << english
          end
        end
      end
      @listing.business_hours = []
      7.times do |wday|
        is_open = params[:is_open][wday.to_s].include?('1')
        start_hour = DateTime.parse("1-1-1 #{params[:start_hour][wday.to_s]['(4i)']}: #{params[:start_hour][wday.to_s]['(5i)']}:0") unless params[:start_hour][wday.to_s]['(3i)'].blank?
        end_hour = DateTime.parse("1-1-1 #{params[:end_hour][wday.to_s]['(4i)']}: #{params[:end_hour][wday.to_s]['(5i)']}:0") unless params[:end_hour][wday.to_s]['(3i)'].blank?
        business_hour = BusinessHour.new(wday: wday, is_open: is_open, start_hour: start_hour, end_hour: end_hour)
        @listing.business_hours << business_hour
      end
      unless params[:english_messages].nil?
        @listing.english_messages = []
        params[:english_messages].each do |em|
          unless em.blank?
            english_message = EnglishMessage.find(em.to_i)
            @listing.english_messages << english_message
          end
        end
      end
      @listing.info_admin_id = params[:info_admin_id][0] unless params[:info_admin_id].nil?
      # 保存
      @listing.save!
      respond_to do |format|
        if @listing.update(listing_params)
          format.html { redirect_to manage_listing_listing_images_path(@listing.id), notice: I18n.t('alerts.listings.update.success', model: Listing.model_name.human) }
        else
          format.html { redirect_to manage_listing_listing_images_path(@listing.id), notice: I18n.t('alerts.listings.update.failure', model: Listing.model_name.human) }
        end
      end
    else
      #return render json: { success: false, errors: 'lonlat_failure'}
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
    @listings = Listing.mine(current_user.id).order_by_updated_at_desc
  end

  def search
    #listings = Listing.search(search_params).opened.page(params[:page])
    where = Array.new
    where_id = Array.new
    shop_categories = params[:shop_categories].compact.delete_if(&:empty?) unless params[:shop_categories].blank?
    where_id.push(ActiveRecord::Base.send(:sanitize_sql_array, ["select listing_id from listings_shop_categories where shop_category_id in (:ids)", ids: shop_categories])) unless shop_categories.blank?
    shop_services = params[:shop_services].compact.delete_if(&:empty?) unless params[:shop_services].blank?
    where_id.push(ActiveRecord::Base.send(:sanitize_sql_array, ["select listing_id from listings_shop_services where shop_service_id in (:ids)", ids: shop_services])) unless shop_services.blank?
    sql = "select * from listings "
    where.push("id in (" + where_id.join(" union ") + ")") unless where_id.blank?
    where.push(ActiveRecord::Base.send(:sanitize_sql_array, ["smoking_id in (:ids)", ids: params[:smoking_id]])) unless params[:smoking_id].blank?
    where.push(ActiveRecord::Base.send(:sanitize_sql_array, ["english_id = ?", params[:english_id]])) unless params[:english_id].blank?
    where.push(ActiveRecord::Base.send(:sanitize_sql_array, ["price_high <= ?", params[:price]])) unless params[:price].blank?
    location = params[:location]
    location.gsub(/\\/, "\\\\").gsub(/%/,"\\%").gsub(/_/,"\\_") unless location.blank?
    where.push(ActiveRecord::Base.send(:sanitize_sql_array, ["direction like ?", "%#{location}%"])) unless location.blank?
    where.push("open = true")
    sql += "where " + where.join(" and ") unless where.blank?
    listings = ActiveRecord::Base.connection.execute(sql).to_a
    #gon.listings = listings
    @hit_count = listings.count
    @listings = Kaminari.paginate_array(listings).page(params[:page]).per(10)
    @conditions = search_params
    @listing = Listing.new
  end

  def publish
    authorize! :publish, @listing
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
    authorize! :unpublish, @listing
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
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.where(id: params[:id]).first
      return redirect_to root_path, notice: Settings.listings.error.invalid_listing_id if @listing.blank?
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
      params.require(:listing).permit(
        :user_id, :evaluation_count,
        :ave_total, :ave_accuracy, :ave_communication, :ave_cleanliness,
        :ave_location, :ave_check_in, :ave_cost_performance, :open,
        :zipcode, :location, :location_en, :longitude, :latitude, :delivery_flg, :price,
        :description, :description_en, :title, :title_en, :capacity, :direction, :schedule, :listing_images,
        :cover_image, :cover_image_caption, :cover_video, :cover_video_caption,
        #{shop_categories: []}, {shop_services: []}, {englishes: []},
        :smoking_id,
        :business_hours_remarks, :shop_description, :shop_description_en,
        :price_low, :price_high, :tel, :url, :review_url,
        :recommended, :recommended_en, :visit_benefits, :visit_benefits_en, :visit_benefits_another, :visit_benefits_another_en,
        :price_low_dinner, :price_high_dinner, :link_tabelog, :link_yelp, :link_tripadvisor,
        listing_image_attributes: [:listing_id, :image, :order, :capacity],
      ).merge(user_id: current_user.id)
    end

    def search_params
      params.require(:search).permit(:location, :schedule, :num_of_guest, :price, :keywords, :where,
        #:shop_categories, :shop_services, :englishes
        )
    end
end
