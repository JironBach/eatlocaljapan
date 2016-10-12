# == Schema Information
#
# Table name: profile_images
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  profile_id :integer
#  image      :string           default(""), not null
#  caption    :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_profile_images_on_profile_id  (profile_id)
#  index_profile_images_on_user_id     (user_id)
#
class ProfileImage < ApplicationRecord
  belongs_to :user
  belongs_to :profile

  mount_uploader :image, DefaultImageUploader

  validates :user_id, presence: true
  validates :profile_id, presence: true
  validates :image, presence: true
  # validates :order_num, numericality: {
  #   only_integer: true,
  #   equal_to: 0 # set has_one association
  # }

  scope :mine, ->(user_id) { where(user_id: user_id) }

  class << self
    def minimun_requirement?(user_id, profile_id)
      profile_image = ProfileImage.find_by(user_id: user_id, profile_id: profile_id)
      profile_image&.image.present?
    end
  end
end
