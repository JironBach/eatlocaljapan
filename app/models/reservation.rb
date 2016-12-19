# == Schema Information
#
# Table name: reservations
#
#  id                     :integer          not null, primary key
#  host_id                :integer
#  guest_id               :integer
#  listing_id             :integer
#  schedule               :date             not null
#  num_of_people          :integer          not null
#  msg                    :text             default("")
#  progress               :integer          default(0), not null
#  reason                 :text             default("")
#  review_mail_sent_at    :datetime
#  review_expiration_date :datetime
#  review_landed_at       :datetime
#  reviewed_at            :datetime
#  reply_mail_sent_at     :datetime
#  reply_landed_at        :datetime
#  replied_at             :datetime
#  review_opened_at       :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  time                   :time
#  reservation_time_unit  :integer
#  in_english             :boolean
#
# Indexes
#
#  index_reservations_on_guest_id    (guest_id)
#  index_reservations_on_host_id     (host_id)
#  index_reservations_on_listing_id  (listing_id)
#
class Reservation < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  belongs_to :guest, class_name: 'User', foreign_key: 'guest_id'
  belongs_to :listing
  has_one :review
  has_one :ngevent, class_name: 'UserNgevent', dependent: :destroy

  enum progress: {requested: 0, canceled: 1, holded: 2, accepted: 3, rejected: 4, listing_closed: 5}

  validates :host_id, :guest_id, :listing_id, :schedule, :time, :num_of_people, :progress, presence: true
  validates :schedule, date: {after: Time.zone.now.yesterday.end_of_day}, allow_blank: true
  validates \
    :num_of_people,
    numericality: \
      {
        only_integer: true,
        greater_than_or_equal_to: 0,
        less_than_or_equal_to: ->(record) { record.listing.free_spaces(record.schedule, record.time, record.reservation_time_unit) }
      },
    allow_blank: true

  scope :as_guest, ->(user_id) { where(guest_id: user_id) }
  scope :as_host, ->(user_id) { where(host_id: user_id) }
  scope :order_by_created_at_desc, -> { order('created_at desc') }
  scope :new_requests, ->(user_id) { where(host_id: user_id).requested }
  scope :finished_before_yesterday, -> { where('schedule <= ?', Time.zone.yesterday) }
  scope :review_mail_never_be_sent, -> { where(review_mail_sent_at: nil) }
  scope :reviewed, -> { where.not(reviewed_at: nil) }
  scope :review_reply_mail_never_be_sent, -> { where(reply_mail_sent_at: nil) }
  scope :review_open?, -> { where(arel_table[:review_opened_at].not_eq(nil)) }
  scope \
    :at,
    ->(date, time, time_unit) do
      ->(value) { Arel::Nodes.build_quoted(value) }
      make_interval = \
        ->(years: 0, months: 0, weeks: 0, days: 0, hours: 0, minutes: 0, seconds: 0) do
          Arel::Nodes::NamedFunction.new('make_interval', [years, months, weeks, days, hours, minutes, seconds])
        end
      # TODO: need to modify about late night behavior
      minutes_since = ->(from, minutes) { Arel::Nodes::InfixOperation.new('+', from, make_interval.(minutes: minutes)) }
      coalesce = ->(*values) { Arel::Nodes::NamedFunction.new('COALESCE', values) }
      includes(:listing) \
        .references(:lisiting) \
        .where(schedule: date) \
        .where.not(
          arel_table[:time].gteq(time.since((time_unit || 15).minutes).to_s(:time)) \
            .or(minutes_since.(arel_table[:time], coalesce.(arel_table[:reservation_time_unit], Arel::Nodes.build_quoted(15))).lteq(time.to_s(:time)))
        )
    end

  def occupied_frames
    (num_of_people.to_f / listing.reservation_frame).ceil
  end

  def continued?
    requested? || holded?
  end

  def subject_of_update_mail
    return I18n.t('reservation_mailer.send_update_reservation_notification.subject.canceled') if canceled?
    return I18n.t('reservation_mailer.send_update_reservation_notification.subject.holded') if holded?
    return I18n.t('reservation_mailer.send_update_reservation_notification.subject.accepted') if accepted?
    return I18n.t('reservation_mailer.send_update_reservation_notification.subject.rejected') if rejected?
  end

  def save_review_landed_at_now
    self.review_landed_at = Time.zone.now
    save
  end

  def save_reply_landed_at_now
    self.reply_landed_at = Time.zone.now
    save
  end

  def save_reviewed_at_now
    self.reviewed_at = Time.zone.now
    save
  end

  def save_replied_at_now
    self.replied_at = Time.zone.now
    save
  end

  def save_reply_mail_sent_at_now
    self.reply_mail_sent_at = Time.zone.now
    save
  end

  def save_review_opened_at_now
    self.review_opened_at = Time.zone.now
    save
  end
end
