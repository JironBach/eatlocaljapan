class AddColumnsToListing < ActiveRecord::Migration
  def change
    add_column :listing, :smoking_id, :integer
    add_column :listing, :english_support, :integer
    add_column :listing, :business_hours, :string
    add_column :listing, :restaurant_ja, :string
    add_column :listing, :restaurant_en, :string
    add_column :listing, :menu_ja, :string
    add_column :listing, :menu_en, :string
    add_column :listing, :price_low, :integer
    add_column :listing, :price_high, :integer
    add_column :listing, :address_text, :string
    add_column :listing, :address_map, :string
    add_column :listing, :tel, :string
    add_column :listing, :website_url, :string
    add_column :listing, :reviewsite_url, :string
    add_column :listing, :recommended_ja, :string
    add_column :listing, :recommended_en, :string
    add_column :listing, :visit_benefits, :string
    add_column :listing, :visit_benefits_another, :string
  end
end
