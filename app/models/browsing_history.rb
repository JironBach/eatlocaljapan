# == Schema Information
#
# Table name: browsing_histories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  listing_id :integer
#  viewed_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_browsing_histories_on_listing_id  (listing_id)
#  index_browsing_histories_on_user_id     (user_id)
#  index_browsing_histories_on_viewed_at   (viewed_at)
#
class BrowsingHistory < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  validates :user_id, presence: true
  validates :listing_id, presence: true

  class << self
    def insert_record(user_id, listing_id)
      BrowsingHistory.create(
        user_id: user_id,
        listing_id: listing_id,
        viewed_at: Time.zone.now.to_date
      )
    end
  end
end
