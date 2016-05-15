class ModifyListing < ActiveRecord::Migration
  def change
    add_column :listings, :title_en, :string
    add_column :listings, :price_low_dinner, :integer
    add_column :listings, :price_high_dinner, :integer
    add_column :listings, :english_message_id, :integer
    add_column :listings, :info_admin_id, :integer
    add_column :listings, :link_tabelog, :string
    add_column :listings, :link_yelp, :string
    add_column :listings, :link_tripadvisor, :string
  end
end
