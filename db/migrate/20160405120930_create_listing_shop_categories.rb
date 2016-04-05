class CreateListingShopCategories < ActiveRecord::Migration
  def change
    create_table :listing_shop_categories do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :shop_category, null: false
    end
  end
end
