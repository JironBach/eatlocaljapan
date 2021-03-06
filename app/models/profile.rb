# == Schema Information
#
# Table name: profiles
#
#  id                   :integer          not null, primary key
#  user_id              :integer          not null
#  first_name           :string           default("")
#  last_name            :string           default("")
#  birthday             :date
#  gender               :integer
#  phone                :string           default("")
#  phone_verification   :boolean          default(FALSE)
#  zipcode              :string           default("")
#  location             :string           default("")
#  self_introduction    :text             default("")
#  school               :string           default("")
#  work                 :string           default("")
#  timezone             :string           default("")
#  listing_count        :integer          default(0)
#  wishlist_count       :integer          default(0)
#  bookmark_count       :integer          default(0)
#  reviewed_count       :integer          default(0)
#  reservation_count    :integer          default(0)
#  ave_total            :float            default(0.0)
#  ave_accuracy         :float            default(0.0)
#  ave_communication    :float            default(0.0)
#  ave_cleanliness      :float            default(0.0)
#  ave_location         :float            default(0.0)
#  ave_check_in         :float            default(0.0)
#  ave_cost_performance :float            default(0.0)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#

class Profile < ApplicationRecord
  belongs_to :user
  has_one :profile_image, dependent: :destroy
  has_one :profile_video, dependent: :destroy

  enum gender: {female: 0, male: 1, others: 2, not_specified: 3}

  validates :user_id, presence: true

  def minimum_requirement?
    [:first_name, :last_name].all? { |field| self[field].present? }
  end
end
