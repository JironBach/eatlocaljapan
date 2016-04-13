# == Schema Information
#
# Table name: profiles
#
#  id                   :integer          not null, primary key
#  user_id              :integer          not null
#  first_name           :string(255)      default("")
#  last_name            :string(255)      default("")
#  birthday             :date
#  gender               :integer
#  phone                :string(255)      default("")
#  phone_verification   :boolean          default(FALSE)
#  zipcode              :string(255)      default("")
#  location             :string(255)      default("")
#  self_introduction    :text
#  school               :string(255)      default("")
#  work                 :string(255)      default("")
#  timezone             :string(255)      default("")
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

class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :profile_image, dependent: :destroy
  has_one :profile_video, dependent: :destroy

  enum gender: { female: 0, male: 1, others: 2, not_specified: 3 }

  validates :user_id, presence: true

  def self.minimun_requirement?(user_id)
    profile = Profile.where(user_id: user_id).first
    if profile.first_name.present? && 
      profile.last_name.present? && 
      profile.birthday.present? && 
      profile.phone.present? && 
      profile.location.present? && 
      profile.self_introduction.present?
      return true
    else
      return false
    end
  end
end
