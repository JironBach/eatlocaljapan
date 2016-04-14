class CreateListingShopCategories < ActiveRecord::Migration
  def change
    create_table :listing_shop_categories do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :shop_category, null: false
    end

    add_index :listing_shop_categories, [:listing_id, :shop_category_id], unique: true, :name => 'index_listing_shop_categories'
  end
end
