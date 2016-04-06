class AddColumnsToListing < ActiveRecord::Migration
  def change
    add_column :listing, :smoking_id, :integer
    add_column :listing, :english_id, :integer
    add_column :listing, :business_hours_id, :string
    add_column :listing, :description, :text
    add_column :listing, :description_en, :text
    add_column :listing, :price_low, :integer
    add_column :listing, :price_high, :integer
    add_column :listing, :address, :string
    add_column :listing, :tel, :string
    add_column :listing, :url, :string
    add_column :listing, :review_url, :string
    add_column :listing, :recommended, :text
    add_column :listing, :recommended_en, :text
    add_column :listing, :visit_benefits, :string
    add_column :listing, :visit_benefits_another, :string
  end
end
