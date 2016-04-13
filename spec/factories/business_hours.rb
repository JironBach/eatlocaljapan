# == Schema Information
#
# Table name: business_hours
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :integer
#  is_open    :boolean          not null
#  true       :boolean          not null
#  wday       :integer          not null
#  start_hour :time
#  end_hour   :time
#

FactoryGirl.define do
  factory :business_hour do
    
  end

end
