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
#  has_lunch_break        :boolean          default(FALSE), not null
#
# Indexes
#
#  index_business_hours_on_listing_id_and_wday  (listing_id,wday)
#

class BusinessHour < ApplicationRecord
  belongs_to :listing

  validates :end_hour, date: {after: :start_hour}, if: ->(record) { record.end_hour > record.end_hour.beginning_of_day.since(6.hours) }
  with_options(if: :has_lunch_break?) do
    validates :lunch_break_start_hour, date: {after: :start_hour}
    validates :lunch_break_end_hour, date: {after: :lunch_break_start_hour, before: :end_hour}
  end

  # NOTE: keep process to use utc threfore business hours comes from time type columns
  def overnight?
    end_hour < Time.utc(*[:year, :month, :day].map { |field| end_hour.send(field) }, 6, 0, 0)
  end
end
