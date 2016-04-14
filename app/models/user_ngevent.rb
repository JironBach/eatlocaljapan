# == Schema Information
#
# Table name: user_ngevents
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  listing_id     :integer
#  reservation_id :integer
#  reason         :string(255)      not null
#  start          :datetime         not null
#  end            :datetime         not null
#  active         :boolean          default(TRUE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_user_ngevents_on_listing_id      (listing_id)
#  index_user_ngevents_on_reservation_id  (reservation_id)
#  index_user_ngevents_on_user_id         (user_id)
#

class UserNgevent < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  belongs_to :reservation

  validates :user_id, presence: true
  validates :start, presence: true, date: { after: Time.zone.now.yesterday.end_of_day }
  validates :end, presence: true, date: { after: :start }
  validate do |event|
    ng_days = UserNgevent.ng_days(event.id, event.user_id, event.listing_id)
    unless (event.consecutive_days & ng_days).size.zero?
      errors.add(:ng_days, 'NGevent is already exists at this day')
    end
  end

  scope :mine, -> user_id { where(user_id: user_id) }
  scope :order_by_updated_at_desc, -> { order('updated_at desc') }
  scope :opened, -> { where(active: true) }
  scope :not_opened, -> { where(active: false) }
  scope :not_me, -> id { where.not(id: id) }
  scope :around_month, -> first_day_of_month do
    where(arel_table[:start].gteq first_day_of_month - 15.day)
    .where(arel_table[:end].lteq first_day_of_month + 1.month + 15.day)
  end
  scope :disable_date?, -> date do
    opened
    .where(arel_table[:start].lteq date.beginning_of_day)
    .where(arel_table[:end].gteq date.end_of_day)
  end

  # @return [1st date, 2nd date, 3rd date, ..., last date]
  def consecutive_days
    (self.start.to_date .. self.end.to_date).to_a
  end

  # 2015-10-03 00:00:00.000000 -> 2015-10-02 23:59:59.999999
  # @return self
  def convert_end_of_day
    self.start = self.start.beginning_of_day
    self.end   = (self.end - 1.day).end_of_day
    self
  end

  # @return [Tue, 29 Sep 2015, Wed, 30 Sep 2015, Thu, 01 Oct 2015, Sun, 11 Oct 2015, Mon, 12 Oct 2015 ... ]
  def self.ng_days( ngevent_id, user_id, listing_id = nil )
    ngs = UserNgevent.opened.not_me(ngevent_id).mine(user_id)
    ngs = ngs.where(listing_id: listing_id) if listing_id
    ngs.map( &:consecutive_days ).flatten
  end

  # Usage
  #   Listing.where(UserNgevent.enable_search_condition( Time.now ).exists.not).opened
  #
  # @params date Datetime
  # @return Arel::SelectManager
  def self.enable_search_condition( date )
    listings = Listing.arel_table
    ngevents = UserNgevent.arel_table
    condition = ngevents
      .project(Arel.star)
      .where(arel_table[:active].eq true)
      .where(arel_table[:start].lteq date)
      .where(arel_table[:end].gt date)
      .where(listings[:id].eq( ngevents[:listing_id] ))
  end

end
