module Gmo
  class CheckCreditCardResponse < Response
    attr_accessor :shop_id, :site_id, :job_cd, :amount, :access_id, :access_pass, :order_id, :forwarded, :method, :pay_times, :approve, :card_no, :tran_id, :tran_date

    def initialize(member_id:, **options)
      super(options)
      self.site_id = config.site_id
      self.shop_id = config.shop_id
    end

    def response_valid?
      check_string == \
        link.response_check_string(order_id: order_id, forwarded: forwarded, method: method, pay_times: pay_times, approve: approve, tran_id: tran_id, tran_date: tran_date)
    end
  end
end
