class ModifyListing < ActiveRecord::Migration
  def change
    add_column :listings, :title_en, :string
    add_column :listings, :price_low_night, :integer
    add_column :listings, :price_high_night, :integer
    add_column :listings, :english_message_id, :integer
    add_column :listings, :info_admin_id, :integer
  end
end
