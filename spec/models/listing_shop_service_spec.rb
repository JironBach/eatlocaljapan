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
# Indexes
#
#  index_listing_shop_services_on_listing_id_and_shop_service_id  (listing_id,shop_service_id) UNIQUE
#

require 'rails_helper'

RSpec.describe ListingShopService, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
