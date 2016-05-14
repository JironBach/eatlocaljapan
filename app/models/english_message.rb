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

class EnglishMessage < ActiveRecord::Base
end
