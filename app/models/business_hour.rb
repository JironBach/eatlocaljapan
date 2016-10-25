# == Schema Information
#
# Table name: business_hours
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :integer
#  wday       :integer          not null
#  is_open    :boolean          default(TRUE), not null
#  start_hour :time
#  end_hour   :time
#
# Indexes
#
#  index_business_hours_on_listing_id_and_wday  (listing_id,wday) UNIQUE
#
class BusinessHour < ActiveRecord::Base
end
