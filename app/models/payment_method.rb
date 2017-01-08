# == Schema Information
#
# Table name: payment_methods
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  type                  :string
#  encrypted_card_no1    :string
#  encrypted_card_no1_iv :string
#  encrypted_card_no2    :string
#  encrypted_card_no2_iv :string
#  encrypted_card_no3    :string
#  encrypted_card_no3_iv :string
#  encrypted_card_no4    :string
#  encrypted_card_no4_iv :string
#  expired_year          :integer
#  expired_month         :integer
#  gmo_card_seq          :integer
#  registered_at         :datetime
#  created_at            :datetime
#  updated_at            :datetime
#

class PaymentMethod < ApplicationRecord
  belongs_to :user, autosave: true
  has_many :charges, as: :payment_method
  has_many :services, through: :charges

  attr_encrypted :card_no1, :card_no2, :card_no3, :card_no4, key: :encryption_key

  after_validation :regist_member, if: ->(record) { record.errors.empty? }
  before_destroy :prepare_destroy

private
  def regist_member
    Payment.service(:gmo).api(:site) do |api|
      begin
        response = user.gmo_member_seq.positive? && api.search_member(member_id: user.member_id)
      rescue GMO::Payment::APIError => ex
        # HACK: reconsider implementation around error handling
        raise unless ex.error_info['ErrInfo'].split('|').include?('E01390002')
      end
      # HACK: reconsider irregular case, which is success user registration but failed to update user.
      unless response
        user.gmo_member_seq += 1
        api.save_member(member_id: user.member_id)
        Rails.logger.info("member registered: member_id: #{user.member_id}")
      end
    end
    true
  rescue GMO::Payment::APIError => ex
    Rails.logger.error("[error] GMO::Payment::APIError: #{ex.message}")
    # TODO: reconsider error message
    errors.add(:base, :gmo_error)
    false
  end

  def prepare_destroy
    charges.available.blank? ? self : false
  end
end
