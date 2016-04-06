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

require 'rails_helper'

RSpec.describe ListingBusinessHour, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
