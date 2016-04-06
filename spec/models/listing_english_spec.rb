# == Schema Information
#
# Table name: listing_englishes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :integer          not null
#  english_id :integer          not null
#

require 'rails_helper'

RSpec.describe ListingEnglish, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
