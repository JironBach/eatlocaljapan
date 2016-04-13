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

require 'rails_helper'

RSpec.describe BusinessHour, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
