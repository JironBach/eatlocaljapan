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
FactoryGirl.define do
  factory :prefecture do
  end
end
