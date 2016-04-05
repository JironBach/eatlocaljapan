# == Schema Information
#
# Table name: menus
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  listing_id     :integer          not null
#  menu           :string           not null
#  menu_en        :string
#  description    :string
#  description_en :string
#

require 'rails_helper'

RSpec.describe Menu, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
