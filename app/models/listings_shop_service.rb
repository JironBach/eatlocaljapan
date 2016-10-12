# == Schema Information
#
# Table name: listings_shop_services
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  listing_id      :integer          not null
#  shop_service_id :integer          not null
#
# Indexes
#
#  index_listings_shop_services_on_listing_id_and_shop_service_id  (listing_id,shop_service_id) UNIQUE
#
class ListingsShopService < ApplicationRecord
  belongs_to :listing
  belongs_to :shop_service
end
