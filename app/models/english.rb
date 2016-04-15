# == Schema Information
#
# Table name: englishes
#
#  id      :integer          not null, primary key
#  name    :string           not null
#  name_en :string           not null
#

class English < ActiveRecord::Base
  has_and_belongs_to_many :listing
end
