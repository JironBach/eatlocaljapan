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

class CreditCard < PaymentMethod
  before_destroy :delete_credit_card

private
  def delete_credit_card
    Payment.service(:gmo).api(:site) do |api|
      api.search_member(member_id: user.member_id)
      api.delete_card(member_id: user.member_id, seq_mode: 1, card_seq: gmo_card_seq)
      Rails.logger.info("card destoryed: member_id: #{user.member_id}, sequence: #{gmo_card_seq}, card_no: #{card_no}, expired_on: #{expired_on}")
    end
    self
  rescue GMO::Payment::APIError => ex
    if ex.error_info['ErrInfo'].split('|').include?('E01240002')
      self
    else
      Rails.logger.error("[error] GMO::Payment::APIError: #{ex.message}")
      errors.add(:base, :gmo_error)
      false
    end
  end
end
