# == Schema Information
#
# Table name: smokings
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#  name_en    :string           not null
#

require 'rails_helper'

RSpec.describe Smoking, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
