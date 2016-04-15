# == Schema Information
#
# Table name: shop_categories
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#  name_en    :string           not null
#

class ShopCategory < ActiveRecord::Base
  has_and_belongs_to_many :listing
end
