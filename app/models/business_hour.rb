# == Schema Information
#
# Table name: business_hours
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  wday       :integer          not null
#  start_hour :integer          not null
#  end_hour   :integer          not null
#

class BusinessHour < ActiveRecord::Base
end
