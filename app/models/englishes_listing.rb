# == Schema Information
#
# Table name: englishes_listings
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :integer          not null
#  english_id :integer          not null
#
# Indexes
#
#  index_englishes_listings_on_listing_id_and_english_id  (listing_id,english_id) UNIQUE
#

class EnglishesListing < ActiveRecord::Base
  belongs_to :english
  belongs_to :listing
end
