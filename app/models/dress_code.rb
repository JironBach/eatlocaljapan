# == Schema Information
#
# Table name: dress_codes
#
#  id         :integer          not null, primary key
#  listing_id :integer
#  wafuku     :boolean          default(FALSE)
#  note       :text             default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_dress_codes_on_listing_id  (listing_id)
#
class DressCode < ApplicationRecord
  belongs_to :listing

  validates :listing_id, presence: true

  scope :order_asc, -> { order('order_num asc') }
  scope :records, ->(listing_id) { where(listing_id: listing_id) }
end
