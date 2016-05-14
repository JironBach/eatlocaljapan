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

require 'rails_helper'

RSpec.describe InfoAdmin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
