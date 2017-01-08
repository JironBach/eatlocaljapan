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

class CreditCard < PaymentMethod
  scope \
    :available,
    -> { where(arel_table[:expired_year].gt((now = Time.zone.now).year).or(arel_table[:expired_year].eq(now.year).and(arel_table[:expired_month].gteq(now.month)))) }

  after_validation :regist_credit_card, on: :create, if: ->(record) { record.errors.empty? }
  after_validation :update_credit_card, on: :update, if: ->(record) { record.errors.empty? }
  before_destroy :delete_credit_card

  validates :card_no1, :card_no2, :card_no3, :card_no4, :expired_year, :expired_month, presence: true
  validates :card_no1, :card_no2, :card_no3, :card_no4, numericality: {only_integer: true}, length: {is: 4}, allow_blank: true
  validates :expired_year, numericality: {only_integer: true, greater_than_or_equal_to: ->(record) { Time.zone.now.year }}, allow_blank: true
  validates :expired_month, numericality: {only_integer: true, less_than_or_equal_to: 12}, allow_blank: true

  def card_no(separator: '')
    (fields = (1..4).map { |no| send("card_no#{no}") }).all?(&:present?) && fields.join(separator) || ''
  end

  def crushed_card_no(separator: '-')
    (fields = [card_no1&.gsub(/(?<=\A.).*/) { '*' * $&.length }, '*' * card_no2&.length, '*' * card_no3&.length, card_no4]).all?(&:present?) && fields.join(separator) || ''
  end

  def expired_on(format: '%<expired_year>02d%<expired_month>02d')
    attributes.values_at('expired_year', 'expired_month').all?(&:present?) && format % {expired_year: expired_year % 100, expired_month: expired_month} || nil
  end

  def expired?
    (now = Time.zone.now).year > expired_year || now.year == expired_year && now.month > expired_month
  end

private
  def regist_credit_card
    Payment.service(:gmo).api(:site) do |api|
      response = api.save_card(member_id: user.member_id, seq_mode: 1, default_flag: 1, card_no: card_no, expire: expired_on)
      self.gmo_card_seq = response['CardSeq']
      self.registered_at = Time.zone.now
      Rails.logger.info("card registered: member_id: #{user.member_id}, sequence: #{gmo_card_seq}, card_no: #{crushed_card_no}, expired_on: #{expired_on}")
    end
    true
  rescue GMO::Payment::APIError => ex
    Rails.logger.error("[error] GMO::Payment::APIError: #{ex.message}")
    # TODO: reconsider error message
    errors.add(:base, :gmo_error)
    false
  end

  def update_credit_card
    Payment.service(:gmo).api(:site) do |api|
      response = api.search_card(member_id: user.member_id, seq_mode: 1, card_seq: gmo_card_seq)
      if response['DeleteFlag'] == '1'
        regist_credit_card
      else
        api.save_card(member_id: user.member_id, seq_mode: 1, card_seq: gmo_card_seq, default_flag: 1, card_no: card_no, expire: expired_on)
        Rails.logger.info("card updated: member_id: #{user.member_id}, sequence: #{gmo_card_seq}, card_no: #{crushed_card_no}, expired_on: #{expired_on}")
        true
      end
    end
  rescue GMO::Payment::APIError => ex
    Rails.logger.error("[error] GMO::Payment::APIError: #{ex.message}")
    errors.add(:base, :gmo_error)
    false
  end

  def delete_credit_card
    Payment.service(:gmo).api(:site) do |api|
      api.search_member(member_id: user.member_id)
      api.delete_card(member_id: user.member_id, seq_mode: 1, card_seq: gmo_card_seq)
      Rails.logger.info("card destoryed: member_id: #{user.member_id}, sequence: #{gmo_card_seq}, card_no: #{crushed_card_no}, expired_on: #{expired_on}")
    end
    self
  rescue GMO::Payment::APIError => ex
    Rails.logger.error("[error] GMO::Payment::APIError: #{ex.message}")
    errors.add(:base, :gmo_error)
    false
  end
end
