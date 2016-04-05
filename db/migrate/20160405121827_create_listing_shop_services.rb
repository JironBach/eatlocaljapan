class CreateListingShopServices < ActiveRecord::Migration
  def change
    create_table :listing_shop_services do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :shop_service, null: false
    end
  end
end
