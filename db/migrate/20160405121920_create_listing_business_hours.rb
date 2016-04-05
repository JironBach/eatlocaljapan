class CreateListingBusinessHours < ActiveRecord::Migration
  def change
    create_table :listing_business_hours do |t|
      t.timestamps null: false

      t.references :listing, null: false
      t.references :business_hour, null: false
    end
  end
end
