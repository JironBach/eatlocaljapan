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

class ListingBusinessHour < ActiveRecord::Base
end
