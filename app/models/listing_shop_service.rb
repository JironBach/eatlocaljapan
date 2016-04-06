# == Schema Information
#
# Table name: listing_shop_services
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  listing_id      :integer          not null
#  shop_service_id :integer          not null
#

class ListingShopService < ActiveRecord::Base
end
