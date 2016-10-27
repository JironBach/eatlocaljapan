# == Schema Information
#
# Table name: business_hours
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  listing_id             :integer
#  wday                   :integer
#  is_open                :boolean          default(TRUE), not null
#  start_hour             :time
#  end_hour               :time
#  type                   :string
#  lunch_break_start_hour :time
#  lunch_break_end_hour   :time
#
# Indexes
#
#  index_business_hours_on_listing_id_and_wday  (listing_id,wday)
#

require 'rails_helper'

RSpec.describe BusinessHour, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
