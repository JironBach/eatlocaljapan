# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  uid                    :string           default(""), not null
#  provider               :string           default(""), not null
#  username               :string
#  admin                  :boolean          default(FALSE)
#  profile_id             :integer
#  gmo_member_seq         :integer          default(0)
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable
  devise :database_authenticatable, :registerable, :lockable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  has_many :auths, dependent: :destroy
  has_one :profile, dependent: :destroy
  # has_many :wishlists, dependent: :destroy
  # has_many :emergency, through: :user_emergencies
  has_one :profile_image, dependent: :destroy
  has_one :profile_video, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :message_thread_users, dependent: :destroy
  has_many :message_threads, through: :message_thread_users, dependent: :destroy
  has_many :payment_methods, dependent: :destroy
  has_many :credit_cards
  has_many :charges, as: :charger, dependent: :destroy
  has_many :services, through: :charges

  validates :email, presence: true
  validates :email, uniqueness: true

  scope :mine, ->(user_id) { where(id: user_id) }

  class << self
    # rubocop:disable Metrics/MethodLength
    def find_for_facebook_oauth(auth, signed_in_resource=nil)
      Rails.logger.debug('------------------------------------------------')
      Rails.logger.debug(auth)
      Rails.logger.debug('------------------------------------------------')
      unless user = User.find_by(provider: auth.provider, uid: auth.uid)
        user = User.new(
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email,
          password: Devise.friendly_token[0, 20]
        )
      end
      user.skip_confirmation!
      user.save

      unless Profile.exists?(user_id: user.id)
        profile = Profile.new(
          user_id: user.id,
          last_name: auth.info.last_name || '',
          first_name: auth.info.first_name || ''
        )
        profile.save

        unless ProfileImage.exists?(user_id: user.id, profile_id: profile.id)
          profile_image = ProfileImage.new(
            user_id: user.id,
            profile_id: profile.id,
            caption: ''
          )
          profile_image.remote_image_url = auth['info']['image'].gsub('http://', 'https://')
          profile_image.save
        end
      end

      auth_obj = Auth.find_bt(user_id: user.id, provider: auth.provider)
      if auth_obj.present?
        auth_obj.access_token = auth.credentials.token
      else
        auth_obj = \
          Auth.new(
            user_id: user.id,
            provider: auth.provider,
            uid: auth.uid,
            access_token: auth.credentials.token
          )
      end
      auth_obj.save

      user
    end
    # rubocop:enable Metrics/MethodLength

    def create_unique_string
      SecureRandom.uuid
    end

    def user_id_to_profile_id(user_id)
      user = User.find(user_id)
      user.profile.id
    end
  end

  def member_id
    [id, gmo_member_seq].join('-')
  end
end
