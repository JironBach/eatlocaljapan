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
class Menu < ApplicationRecord
end
