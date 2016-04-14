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
# Indexes
#
#  index_listing_englishes_on_listing_id_and_english_id  (listing_id,english_id) UNIQUE
#

FactoryGirl.define do
  factory :listing_english do
    
  end

end
