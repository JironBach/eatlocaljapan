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
FactoryGirl.define do
  factory :smoking do
  end
end
