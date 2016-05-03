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

  permit_params :user_id, :ave_total, :ave_accuracy, :ave_communication, :ave_cleanliness, :ave_location, :ave_check_in, :ave_cost_performance, :open, :zipcode, :location, :longitude, :latitude, :delivery_flg, :price, :description, :title, :capacity, :direction, :cover_image_caption, :business_hours_remarks, :shop_description, :shop_description_en, :price_low, :price_high, :tel, :url, :review_url, :recommended, :recommended_en, :visit_benefits, :visit_benefits_another, :smoking_id,
    english_ids: [], shop_category_ids: [], shop_service_ids: []

  index do
    column :id do |id|
      link_to id.id, admin_listing_path(id)
    end
    column I18n.t('activerecord.attributes.listing.title'), :title
    column I18n.t('activerecord.attributes.listing.shop_categories'), :shop_categories
    column I18n.t('activerecord.attributes.listing.shop_services'), :shop_services
    column I18n.t('activerecord.attributes.listing.description'), :description
    column I18n.t('activerecord.attributes.listing.cover_image'), :cover_image
    column I18n.t('activerecord.attributes.listing.zipcode'), :zipcode
    column I18n.t('activerecord.attributes.listing.location'), :location
    column I18n.t('activerecord.attributes.listing.direction'), :direction
    column I18n.t('activerecord.attributes.listing.smoking_id'), :smoking_id
    column I18n.t('activerecord.attributes.listing.englishes'), :englishes
    # business_hour
    column I18n.t('activerecord.attributes.listing.business_hours_remarks'), :business_hours_remarks
    column I18n.t('activerecord.attributes.listing.shop_description'), :shop_description
    column I18n.t('activerecord.attributes.listing.shop_description_en'), :shop_description_en
    column I18n.t('activerecord.attributes.listing.price_low'), :price_low
    column I18n.t('activerecord.attributes.listing.price_high'), :price_high
    column I18n.t('activerecord.attributes.listing.tel'), :tel
    column I18n.t('activerecord.attributes.listing.url'), :url
    column I18n.t('activerecord.attributes.listing.review_url'), :review_url
    column I18n.t('activerecord.attributes.listing.recommended'), :recommended
    column I18n.t('activerecord.attributes.listing.recommended_en'), :recommended_en
    column I18n.t('activerecord.attributes.listing.visit_benefits'), :visit_benefits
    column I18n.t('activerecord.attributes.listing.visit_benefits_another'), :visit_benefits_another
    actions
  end

  form do |f|
    f.inputs "店舗情報の詳細" do
      f.input :title
      f.input :shop_categories, :as => :check_boxes, collection: ShopCategory.all
      f.input :shop_services, :as => :check_boxes, collection: ShopService.all
      f.input :description
      f.input :cover_image
      f.input :zipcode
      f.input :location
      f.input :direction
      f.input :smoking_id, :as => :select, collection: Smoking.all
      f.input :englishes, :as => :check_boxes, collection: English.all
      # business_hour
      f.input :business_hours_remarks
      f.input :shop_description
      f.input :shop_description_en
      f.input :price_low
      f.input :price_high
      f.input :tel
      f.input :url
      f.input :review_url
      f.input :recommended
      f.input :recommended_en
      f.input :visit_benefits
      f.input :visit_benefits_another
    end
    f.actions
  end

  show do
    attributes_table do
      row I18n.t('activerecord.attributes.listing.title') do
        resource.title
      end
      row I18n.t('activerecord.attributes.listing.shop_categories') do
        # resource.shop_categories
      end
      row I18n.t('activerecord.attributes.listing.shop_services') do
        # resource.shop_services
      end
      row I18n.t('activerecord.attributes.listing.description') do
        resource.description
      end
      row I18n.t('activerecord.attributes.listing.cover_image') do
        resource.cover_image
      end
      row I18n.t('activerecord.attributes.listing.zipcode') do
        resource.zipcode
      end
      row I18n.t('activerecord.attributes.listing.location') do
        resource.location
      end
      row I18n.t('activerecord.attributes.listing.direction') do
        resource.direction
      end
      row I18n.t('activerecord.attributes.listing.smoking_id') do
        # resource.smoking_id
      end
      row I18n.t('activerecord.attributes.listing.englishes') do
        # resource.englishes
      end
      # business_hour
      row I18n.t('activerecord.attributes.listing.business_hours_remarks') do
        resource.business_hours_remarks
      end
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
    end
  end
end
