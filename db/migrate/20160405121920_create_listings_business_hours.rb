class CreateListingsBusinessHours < ActiveRecord::Migration
  def change
    create_table :listings_business_hours do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :business_hour, null: false
    end

    add_index :listings_business_hours, [:listing_id, :business_hour_id], unique: true, :name => 'index_listing_business_hours'
  end
end
