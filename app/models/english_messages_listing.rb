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
class EnglishMessagesListing < ApplicationRecord
  belongs_to :english_message
  belongs_to :listing
end
