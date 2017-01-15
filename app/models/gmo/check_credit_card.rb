module Gmo
  class CheckCreditCard < Request
    attr_accessor :shop_id, :site_id, :member_id, :order_id, :amount, :shop_pass_string, :use_credit, :job_cd, :member_pass_string

    delegate :shop_check_string, :member_check_string, to: :link

    def initialize(member_id:, datetime: Time.zone.now.to_s(:number), **options)
      super(options)
      self.member_id = member_id
      self.order_id = datetime + SecureRandom.hex(6)
      self.amount = 0
      self.use_credit = 1
      self.job_cd = 'CHECK'
      self.site_id = config.site_id
      self.shop_id = config.shop_id
      self.shop_pass_string = shop_check_string(order_id: order_id, amount: amount, tax: nil, timestamp: datetime)
      self.member_pass_string = member_check_string(member_id: member_id, timestamp: datetime)
    end
  end
end
