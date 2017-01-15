# == Schema Information
#
# Table name: payment_methods
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  type          :string
#  gmo_card_seq  :integer
#  registered_at :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  card_no       :string
#  expired_on    :string
#

class PaymentMethod < ApplicationRecord
  belongs_to :user, autosave: true
  has_many :charges, as: :payment_method, autosave: true
  has_many :services, through: :charges

  before_destroy :prepare_destroy

private
  def prepare_destroy
    charges.any?(&:available?) ? false : self
  end
end
