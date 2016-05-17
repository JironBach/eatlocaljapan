ActiveAdmin.register Listing do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

  permit_params :user_id, :open, :ave_total, :ave_accuracy, :ave_communication, :ave_cleanliness, :ave_location, :ave_check_in, :ave_cost_performance, :open, :zipcode, :location, :longitude, :latitude, :delivery_flg, :price, :description, :title, :title_en, :capacity, :direction, :cover_image_caption, :business_hours_remarks, :shop_description, :shop_description_en, :price_low, :price_high, :tel, :url, :review_url, :recommended, :recommended_en, :visit_benefits, :visit_benefits_another, :smoking_id,
    english_ids: [], shop_category_ids: [], shop_service_ids: []

  index do
    selectable_column
    column :id do |id|
      link_to id.id, admin_listing_path(id)
    end
    column I18n.t('activerecord.attributes.listing.title'), :title
    column I18n.t('activerecord.attributes.listing.title_en'), :title_en
    column I18n.t('activerecord.attributes.listing.open'), :open

    column I18n.t('activerecord.attributes.listing.shop_categories') do |sc|
      ShopCategory.where(id: sc.shop_categories).all.pluck(:name).join(', ')
    end
    column I18n.t('activerecord.attributes.listing.shop_services') do |ss|
      ShopService.where(id: ss.shop_services).all.pluck(:name).join(', ')
    end
    #column I18n.t('activerecord.attributes.listing.description'), :description
    column I18n.t('activerecord.attributes.listing.cover_image'), :cover_image
    column I18n.t('activerecord.attributes.listing.zipcode'), :zipcode
    column I18n.t('activerecord.attributes.listing.location'), :location
    #column I18n.t('activerecord.attributes.listing.direction'), :direction
    column I18n.t('activerecord.attributes.listing.smoking_id'), sortable: :smoking_id do |s|
      Smoking.where(id: s.smoking_id).all.pluck(:name).join(', ')
    end
    column I18n.t('activerecord.attributes.listing.englishes') do |e|
      English.where(id: e.englishes).all.pluck(:name).join(', ')
    end
    # business_hour
    #column I18n.t('activerecord.attributes.listing.business_hours_remarks'), :business_hours_remarks
    column I18n.t('activerecord.attributes.listing.shop_description'), :shop_description
    column I18n.t('activerecord.attributes.listing.shop_description_en'), :shop_description_en
    column I18n.t('activerecord.attributes.listing.price_low'), :price_low
    column I18n.t('activerecord.attributes.listing.price_high'), :price_high
    column I18n.t('activerecord.attributes.listing.price_low_dinner'), :price_low_dinner
    column I18n.t('activerecord.attributes.listing.price_high_dinner'), :price_high_dinner
    column I18n.t('activerecord.attributes.listing.tel'), :tel
    column I18n.t('activerecord.attributes.listing.url'), :url
    column I18n.t('activerecord.attributes.listing.review_url'), :review_url
    column I18n.t('activerecord.attributes.listing.recommended'), :recommended
    column I18n.t('activerecord.attributes.listing.recommended_en'), :recommended_en
    column I18n.t('activerecord.attributes.listing.visit_benefits'), :visit_benefits
    column I18n.t('activerecord.attributes.listing.visit_benefits_another'), :visit_benefits_another
    column I18n.t('activerecord.attributes.listing.english_messages'), :english_messages
    column I18n.t('activerecord.attributes.listing.info_admin_id') do |i|
      InfoAdmin.find(i.info_admin_id).name unless i.info_admin_id.nil?
    end
    column I18n.t('activerecord.attributes.listing.link_tabelog'), :link_tabelog
    column I18n.t('activerecord.attributes.listing.link_yelp'), :link_yelp
    column I18n.t('activerecord.attributes.listing.link_tripadvisor'), :link_tripadvisor
    actions
  end

  form do |f|
    f.inputs "店舗情報の詳細" do
      f.input :title
      f.input :title_en
      f.input :open

      f.input :shop_categories, :as => :check_boxes, collection: ShopCategory.all
      f.input :shop_services, :as => :check_boxes, collection: ShopService.all
      #f.input :description
      f.input :cover_image
      f.input :zipcode
      f.input :location
      #f.input :direction
      f.input :smoking_id, :as => :select, collection: Smoking.all
      f.input :englishes, :as => :check_boxes, collection: English.all
      # business_hour
      #f.input :business_hours_remarks
      f.input :shop_description
      f.input :shop_description_en
      f.input :price_low
      f.input :price_high
      f.input :price_low_dinner
      f.input :price_high_dinner
      f.input :tel
      f.input :url
      f.input :review_url
      f.input :recommended
      f.input :recommended_en
      f.input :visit_benefits
      f.input :visit_benefits_another
      f.input :english_messages
      f.input :info_admin_id, :as => :select, collection: InfoAdmin.all
      f.input :link_tabelog
      f.input :link_yelp
      f.input :link_tripadvisor
    end
    f.actions
  end

  show do
    attributes_table do
      row I18n.t('activerecord.attributes.listing.title') do
        resource.title
      end
      row I18n.t('activerecord.attributes.listing.title_en') do
        resource.title_en
      end
      row I18n.t('activerecord.attributes.listing.open') do
        resource.open
      end
      row I18n.t('activerecord.attributes.listing.shop_categories') do
        ShopCategory.where(id: resource.shop_categories).all.pluck(:name).join(', ')
      end
      row I18n.t('activerecord.attributes.listing.shop_services') do
        ShopService.where(id: resource.shop_services).all.pluck(:name).join(', ')
      end
      #row I18n.t('activerecord.attributes.listing.description') do
      #  resource.description
      #end
      row I18n.t('activerecord.attributes.listing.cover_image') do
        resource.cover_image
      end
      row I18n.t('activerecord.attributes.listing.zipcode') do
        resource.zipcode
      end
      row I18n.t('activerecord.attributes.listing.location') do
        resource.location
      end
      #row I18n.t('activerecord.attributes.listing.direction') do
      #  resource.direction
      #end
      row I18n.t('activerecord.attributes.listing.smoking_id') do
        Smoking.where(id: resource.smoking_id).all.pluck(:name).join(', ')
      end
      row I18n.t('activerecord.attributes.listing.englishes') do
        English.where(id: resource.englishes).all.pluck(:name).join(', ')
      end
      # business_hour
      #row I18n.t('activerecord.attributes.listing.business_hours_remarks') do
      #  resource.business_hours_remarks
      #end
      row I18n.t('activerecord.attributes.listing.shop_description') do
        resource.shop_description
      end
      row I18n.t('activerecord.attributes.listing.shop_description_en') do
        resource.shop_description_en
      end
      row I18n.t('activerecord.attributes.listing.price_low') do
        resource.price_low
      end
      row I18n.t('activerecord.attributes.listing.price_high') do
        resource.price_high
      end
      row I18n.t('activerecord.attributes.listing.price_low_dinner') do
        resource.price_low_dinner
      end
      row I18n.t('activerecord.attributes.listing.price_high_dinner') do
        resource.price_high_dinner
      end
      row I18n.t('activerecord.attributes.listing.tel') do
        resource.tel
      end
      row I18n.t('activerecord.attributes.listing.url') do
        resource.url
      end
      row I18n.t('activerecord.attributes.listing.review_url') do
        resource.review_url
      end
      row I18n.t('activerecord.attributes.listing.recommended') do
        resource.recommended
      end
      row I18n.t('activerecord.attributes.listing.recommended_en') do
        resource.recommended_en
      end
      row I18n.t('activerecord.attributes.listing.visit_benefits') do
        resource.visit_benefits
      end
      row I18n.t('activerecord.attributes.listing.visit_benefits_another') do
        resource.visit_benefits_another
      end
      row I18n.t('activerecord.attributes.listing.english_message') do
        resource.english_messages
      end
      row I18n.t('activerecord.attributes.listing.info_admin_id') do
        InfoAdmin.find(resource.info_admin_id).name
      end
      row I18n.t('activerecord.attributes.listing.link_tabelog') do
        resource.link_tabelog
      end
      row I18n.t('activerecord.attributes.listing.link_yelp') do
        resource.link_yelp
      end
      row I18n.t('activerecord.attributes.listing.link_tripadvisor') do
        resource.link_tripadvisor
      end
    end
  end
end
