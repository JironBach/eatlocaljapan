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

require 'rails_helper'

RSpec.describe EnglishMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
