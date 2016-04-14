class CreateListingBusinessHours < ActiveRecord::Migration
  def change
    create_table :listing_business_hours do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :business_hour, null: false
    end

    add_index :listing_business_hours, [:listing_id, :business_hour_id], unique: true
  end
end
