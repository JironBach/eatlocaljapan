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

require 'rails_helper'

RSpec.describe ListingShopCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
