# == Schema Information
#
# Table name: prefectures
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#  name_en    :string           not null
#

require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
