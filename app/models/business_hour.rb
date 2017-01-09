# == Schema Information
#
# Table name: business_hours
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  listing_id             :integer
#  wday                   :integer
#  is_open                :boolean          default(TRUE), not null
#  start_hour             :time
#  end_hour               :time
#  type                   :string
#  lunch_break_start_hour :time
#  lunch_break_end_hour   :time
#
# Indexes
#
#  index_business_hours_on_listing_id_and_wday  (listing_id,wday)
#

class BusinessHour < ApplicationRecord
  belongs_to :listing

  validates :end_hour, date: {after: :start_hour}, if: ->(record) { record.end_hour > record.end_hour.beginning_of_day.since(6.hours) }
  validates :lunch_break_end_hour, date: {after: :lunch_break_start_hour}
end
