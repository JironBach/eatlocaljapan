# == Schema Information
#
# Table name: listing_shop_categories
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  listing_id       :integer          not null
#  shop_category_id :integer          not null
#
# Indexes
#
#  index_listing_shop_categories  (listing_id,shop_category_id) UNIQUE
#

class ListingShopCategory < ActiveRecord::Base
end
