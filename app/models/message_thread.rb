# == Schema Information
#
# Table name: message_threads
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MessageThread < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :message_thread_users, dependent: :destroy
  has_many :users, through: :message_thread_users, dependent: :destroy

  scope :order_by_updated_at_desc, -> { order('updated_at') }
  scope(
    :between,
    ->(from:, to:) do
      tied_to = \
        ->(user) do
          message_thread_users = MessageThreadUser.arel_table
          message_thread_users.project(Arel.star).where(arel_table[:id].eq(message_thread_users[:message_thread_id])).where(message_thread_users[:user_id].eq(user.id)).exists
        end
      where(tied_to.(from)).where(tied_to.(to))
    end
  )
  scope :unreads, ->(user) { includes(:message_thread_users, :messages).where(message_thread_users: {user_id: user.id}, messages: {to_user_id: user.id, read: false}).uniq }

  class << self
    def send_message(from:, to:, message:)
      normalized = \
        {content: '', listing_id: 0, reservation_id: 0, read: false} \
        .each_with_object(message.compact) { |(name, value), result| result[name] = value if result[name].blank? } \
        .merge(from_user_id: from.id, to_user_id: to.id)
      message_thread = between(from: from, to: to).first || new.tap { |instance| [from, to].each { |user| instance.message_thread_users.build(user: user) } }
      message_thread.messages.build(normalized)
      message_thread.save && message_thread || nil
    end

    def unread_messages(user)
      unreads(user).flat_map { |unread| unread.messages.where(to_user: user, read: false) }
    end
  end
end
