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

  permit_params :user_id, :ave_total, :ave_accuracy, :ave_communication, :ave_cleanliness, :ave_location, :ave_check_in, :ave_cost_performance, :open, :zipcode, :location, :longitude, :latitude, :delivery_flg, :price, :description, :title, :capacity, :direction, :cover_image_caption, :business_hours_remarks, :shop_description, :shop_description_en, :price_low, :price_high, :tel, :url, :review_url, :recommended, :recommended_en, :visit_benefits, :visit_benefits_another, smoking_id: []

  form do |f|
    f.inputs "店舗情報の詳細" do
      f.input :title
      # shop_category
      f.input :shop_categories, :as => :check_boxes, collection: ShopCategory.all
      # service_category
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
end
