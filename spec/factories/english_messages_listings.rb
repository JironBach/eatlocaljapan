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
FactoryGirl.define do
  factory :english_messages_listing do
  end
end
