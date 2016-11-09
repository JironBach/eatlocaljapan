# == Schema Information
#
# Table name: englishes
#
#  id      :integer          not null, primary key
#  name    :string           not null
#  name_en :string           not null
#
class English < ApplicationRecord
  has_many :englishes_listings, dependent: :destroy
  has_many :listings, through: :englishes_listings
end
