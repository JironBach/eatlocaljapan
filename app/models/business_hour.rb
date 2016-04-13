# == Schema Information
#
# Table name: business_hours
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :integer
#  is_open    :boolean          default(TRUE), not null
#  wday       :integer          not null
#  start_hour :time
#  end_hour   :time
#

class BusinessHour < ActiveRecord::Base
end
