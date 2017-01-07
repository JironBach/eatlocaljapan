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
  belongs_to :credit_card, polymorphic: true

  validate :charge_overlapping
  validate :credit_card_availability

private
  # NOTE: reconsider this implementation
  def charge_overlapping
    charges.reservation.continuing.where.not(id: id).exists? && errors.add(:base, :overlapped)
  end

  def credit_card_availability
    credit_card.expired? && errors.add(:'credit_card/expiration_date', :expired)
  end
end
