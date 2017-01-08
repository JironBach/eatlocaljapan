# == Schema Information
#
# Table name: charges
#
#  id                  :integer          not null, primary key
#  service_id          :integer
#  type                :string
#  charger_type        :string
#  charger_id          :integer
#  payment_method_type :string
#  payment_method_id   :integer
#  status              :integer
#  order_no            :integer
#  expiration_date     :date
#  ordered_at          :datetime
#  created_at          :datetime
#  updated_at          :datetime
#

class CreditCardCharge < Charge
  validates :service, :payment_method, presence: true
  validate :charge_overlapping
  validate :credit_card_availability

private
  # NOTE: reconsider this implementation
  def charge_overlapping
    charger.charges.reservation.continuing.where.not(id: id).exists? && errors.add(:base, :overlapped)
  end

  def credit_card_availability
    payment_method&.expired? && errors.add(:'payment_method/expiration_date', :expired)
  end
end
