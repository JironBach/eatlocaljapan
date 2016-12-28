# == Schema Information
#
# Table name: messages
#
#  id                :integer          not null, primary key
#  message_thread_id :integer          not null
#  from_user_id      :integer          not null
#  to_user_id        :integer          not null
#  content           :text             default(""), not null
#  read              :boolean          default(FALSE)
#  read_at           :datetime
#  listing_id        :integer          default(0), not null
#  reservation_id    :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_messages_on_from_user_id       (from_user_id)
#  index_messages_on_listing_id         (listing_id)
#  index_messages_on_message_thread_id  (message_thread_id)
#  index_messages_on_reservation_id     (reservation_id)
#  index_messages_on_to_user_id         (to_user_id)
#
class Message < ApplicationRecord
  belongs_to :message_thread, touch: true
  belongs_to :to_user, class_name: 'User', foreign_key: 'to_user_id'
  belongs_to :from_user, class_name: 'User', foreign_key: 'from_user_id'
  belongs_to :reservation

  validates :message_thread, presence: true
  validates :from_user, presence: true
  validates :to_user, presence: true
  validates :content, presence: true

  scope :unread_messages, ->(user_id) { where(to_user_id: user_id, read: false) }
  scope :message_thread, ->(message_thread_id) { where(message_thread_id: message_thread_id) }
  scope :order_by_created_at_desc, -> { order('created_at desc') }
  scope :reservation, ->(reservation_id) { where(reservation_id: reservation_id) }

  class << self
    def make_all_read(message_thread_id, to_user_id)
      Message.where(message_thread_id: message_thread_id, to_user_id: to_user_id, read: false).update_all(read: true, read_at: Time.zone.now)
    end
  end
end
