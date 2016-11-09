# == Schema Information
#
# Table name: listings_shop_categories
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
class ListingsShopCategory < ApplicationRecord
  belongs_to :listing
  belongs_to :shop_category
end
