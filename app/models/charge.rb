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

class Charge < ApplicationRecord
  belongs_to :service
  belongs_to :charger, polymorphic: true
  belongs_to :payment_method, polymorphic: true

  scope :available, -> { where.not(status: statuses[:termintate]).where(arel_table[:expiration_date].eq(nil).or(arel_table[:expiration_date].gteq(Time.zone.now.to_date))) }
  scope(
    :continuing,
    -> do
      where \
        .not(status: statuses.values_at(:canceling, :termintate)) \
        .where(arel_table[:expiration_date].eq(nil).or(arel_table[:expiration_date].gteq(Time.zone.now.to_date)))
    end
  )
  scope :reservation, -> { includes(:service).where(services: {id: Service.reservation.id}) }

  enum status: {ordered: 0, charging: 1, paid: 2, canceling: 3, terminated: 4}
end
