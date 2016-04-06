class AddColumnsToListing < ActiveRecord::Migration
  def change
    add_column :listings, :smoking_id, :integer
    add_column :listings, :english_id, :integer
    add_column :listings, :business_hours_id, :string
    add_column :listings, :shop_description, :text
    add_column :listings, :shop_description_en, :text
    add_column :listings, :price_low, :integer
    add_column :listings, :price_high, :integer
    add_column :listings, :address, :string
    add_column :listings, :tel, :string
    add_column :listings, :url, :string
    add_column :listings, :review_url, :string
    add_column :listings, :recommended, :text
    add_column :listings, :recommended_en, :text
    add_column :listings, :visit_benefits, :string
    add_column :listings, :visit_benefits_another, :string
  end
end
