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
FactoryGirl.define do
  factory :info_admin do
  end
end
