# == Schema Information
#
# Table name: services
#
#  id          :integer          not null, primary key
#  name        :string
#  name_en     :string
#  code        :string
#  charge_type :integer
#  amount      :integer
#  description :string
#  created_at  :datetime
#  updated_at  :datetime
#

class Service < ApplicationRecord
  has_many :charges
  has_many :chargers, through: :charges
  has_many :users, through: :charged, source: :charger, source_type: 'User'
  has_many :listings, through: :charged, source: :charger, source_type: 'Listing'

  enum charge_type: {monthly: 0, each_time: 1}

  all.find_each { |service| define_singleton_method(service.code) { service } }
end
