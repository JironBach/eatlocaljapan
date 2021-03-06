# == Schema Information
#
# Table name: message_thread_users
#
#  id                :integer          not null, primary key
#  message_thread_id :integer          not null
#  user_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_message_thread_users_on_message_thread_id              (message_thread_id)
#  index_message_thread_users_on_message_thread_id_and_user_id  (message_thread_id,user_id) UNIQUE
#  index_message_thread_users_on_user_id                        (user_id)
#
class MessageThreadUser < ApplicationRecord
  belongs_to :message_thread
  belongs_to :user

  validates :message_thread, presence: true
  validates :user, presence: true

  scope :user_joins, ->(user_id) { where(user_id: user_id) }
  scope :mine, ->(user_id) { where(user_id: user_id) }
  scope :order_by_updated_at_desc, -> { order('updated_at desc') }
  scope :order_by_updated_at_asc, -> { order('updated_at asc') }
  scope :message_thread, ->(message_thread_id) { where(message_thread_id: message_thread_id) }

  class << self
    def counterpart_user(message_thread_id, my_user_id)
      user_ids = MessageThreadUser.message_thread(message_thread_id).pluck(:user_id)
      user_ids.each do |ui|
        return ui unless ui == my_user_id
      end
    end

    # rubocop:disable Style/PredicateName
    def is_a_member(message_thread_id, user_id)
      MessageThreadUser.exists?(message_thread_id: message_thread_id, user_id: user_id)
    end
    # rubocop:enable Style/PredicateName
  end
end
