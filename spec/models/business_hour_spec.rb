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

require 'rails_helper'

RSpec.describe BusinessHour, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
