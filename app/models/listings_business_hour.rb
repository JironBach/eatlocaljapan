# == Schema Information
#
# Table name: listing_business_hours
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  listing_id       :integer          not null
#  business_hour_id :integer          not null
#
# Indexes
#
#  index_listing_business_hours_on_listing_id_and_business_hour_id  (listing_id,business_hour_id) UNIQUE
#

class ListingsBusinessHour < ActiveRecord::Base
end
