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
class ShopService < ActiveRecord::Base
  # rubocop:disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :listing
  # rubocop:enable Rails/HasAndBelongsToMany
end
