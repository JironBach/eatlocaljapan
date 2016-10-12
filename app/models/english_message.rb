# == Schema Information
#
# Table name: english_messages
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  name_en    :string
#
class EnglishMessage < ApplicationRecord
  has_many :english_messages_listings, dependent: :destroy
  has_many :listings, through: :english_messages_listings
end
