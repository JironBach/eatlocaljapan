# == Schema Information
#
# Table name: shop_services
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#  name_en    :string           not null
#
class ShopService < ApplicationRecord
  has_many :listings_shop_services, dependent: :destroy
  has_many :listings, through: :listings_shop_services
end
