# == Schema Information
#
# Table name: english_messages_listings
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  listing_id         :integer          not null
#  english_message_id :integer          not null
#

require 'rails_helper'

RSpec.describe EnglishMessagesListing, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
