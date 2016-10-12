# == Schema Information
#
# Table name: info_admins
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  name_en    :string
#
class InfoAdmin < ApplicationRecord
  has_many :listings
end
