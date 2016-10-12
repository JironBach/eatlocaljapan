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

  validates :host_id, presence: true
  validates :guest_id, presence: true
  validates :listing_id, presence: true
  validates :schedule, presence: true, date: {after: Time.zone.now.yesterday.end_of_day}
  validates :num_of_people, presence: true
  validates :progress, presence: true

  scope :as_guest, ->(user_id) { where(guest_id: user_id) }
  scope :as_host, ->(user_id) { where(host_id: user_id) }
  scope :order_by_created_at_desc, -> { order('created_at desc') }
  scope :new_requests, ->(user_id) { where(host_id: user_id).requested }
  scope :finished_before_yesterday, -> { where('schedule <= ?', Time.zone.yesterday) }
  scope :review_mail_never_be_sent, -> { where(review_mail_sent_at: nil) }
  scope :reviewed, -> { where.not(reviewed_at: nil) }
  scope :review_reply_mail_never_be_sent, -> { where(reply_mail_sent_at: nil) }
  scope :review_open?, -> { where(arel_table[:review_opened_at].not_eq(nil)) }

  def continued?
    requested? || holded?
  end

  def string_of_progress
    return I18n.t('string_of_progress.requested') if requested?
    return I18n.t('string_of_progress.canceled') if canceled?
    return I18n.t('string_of_progress.holded') if holded?
    return I18n.t('string_of_progress.accepted') if accepted?
    return I18n.t('string_of_progress.rejected') if rejected?
    return I18n.t('string_of_progress.unpublished') if listing_closed?
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
