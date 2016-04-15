# == Schema Information
#
# Table name: emergencies
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  profile_id   :integer
#  name         :string(255)      not null
#  phone        :string(255)
#  email        :string(255)
#  relationship :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_emergencies_on_profile_id  (profile_id)
#  index_emergencies_on_user_id     (user_id)
#

class Emergency < ActiveRecord::Base
end
