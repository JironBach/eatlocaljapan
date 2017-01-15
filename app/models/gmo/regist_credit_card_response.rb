module Gmo
  class RegistCreditCardResponse < Response
    attr_accessor :site_id, :member_id, :shop_id, :order_id, :datetime

    def initialize(member_id:, **options)
      super(options)
      self.member_id = member_id
      self.site_id = config.site_id
      self.shop_id = config.shop_id
    end

    def response_valid?
      check_string == link.response_check_string(member_id: member_id, order_id: order_id, datetime: datetime)
    end
  end
end
