# == Schema Information
#
# Table name: listings_business_hours
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  listing_id       :integer          not null
#  business_hour_id :integer          not null
#
# Indexes
#
#  index_listing_business_hours  (listing_id,business_hour_id) UNIQUE
#
class ListingsBusinessHour < ActiveRecord::Base
end
