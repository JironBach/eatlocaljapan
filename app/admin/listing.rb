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
    f.inputs "郵便番号" do
      f.input :zipcode
    end
    f.inputs "禁煙・喫煙" do
      f.input :smoking_id, :as => :select, collection: Smoking.all
    end
    f.actions
  end
end
