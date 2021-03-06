# == Schema Information
#
# Table name: reviews
#
#  id               :integer          not null, primary key
#  guest_id         :integer
#  host_id          :integer
#  reservation_id   :integer
#  listing_id       :integer
#  accuracy         :integer          default(0)
#  communication    :integer          default(0)
#  cleanliness      :integer          default(0)
#  location         :integer          default(0)
#  check_in         :integer          default(0)
#  cost_performance :integer          default(0)
#  total            :integer          default(0)
#  msg              :text             default("")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_reviews_on_guest_id        (guest_id)
#  index_reviews_on_host_id         (host_id)
#  index_reviews_on_listing_id      (listing_id)
#  index_reviews_on_reservation_id  (reservation_id)
#
class Review < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'
  belongs_to :listing
  belongs_to :reservation
  has_one :review_reply

  validates :guest_id, presence: true
  validates :host_id, presence: true
  validates :reservation_id, presence: true
  validates :listing_id, presence: true
  validates :msg, presence: true
  validates :accuracy, presence: true
  validates :communication, presence: true
  validates :cleanliness, presence: true
  validates :location, presence: true
  validates :check_in, presence: true
  validates :cost_performance, presence: true
  validates :total, presence: true

  scope :this_listing, ->(listing_id) { where(listing_id: listing_id) }
  scope :order_by_created_at_desc, -> { order('created_at desc') }
  scope :order_by_updated_at_desc, -> { order('updated_at desc') }
  scope :i_do, ->(user_id) { where(guest_id: user_id) }
  scope :they_do, ->(user_id) { where(host_id: user_id) }

  def calc_average
    calc_ave_of_listing
    calc_ave_of_profile
  end

  def calc_ave_of_listing
    l = Listing.find(listing_id)
    r_count = Review.where(listing_id: listing_id).count
    ave_total = (l.ave_total + total) / r_count
    l.ave_total = ave_total
    l.save
  end

  def calc_ave_of_profile
    prof = Profile.find(host_id)
    r_count = Review.where(host_id: host_id).count
    ave_total = (prof.ave_total + total) / r_count
    prof.ave_total = ave_total
    prof.save
  end
end
