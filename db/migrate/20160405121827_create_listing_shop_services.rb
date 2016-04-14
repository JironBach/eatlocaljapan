class CreateListingShopServices < ActiveRecord::Migration
  def change
    create_table :listing_shop_services do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :shop_service, null: false
    end

    add_index :listing_shop_services, [:listing_id, :shop_service_id], unique: true
  end
end
