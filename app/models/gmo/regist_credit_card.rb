module Gmo
  class RegistCreditCard < Request
    attr_accessor :site_id, :member_id, :shop_id, :order_id, :member_pass_string

    delegate :member_check_string, to: :link

    def initialize(member_id:, order_id:, **options)
      super(options)
      self.member_id = member_id
      self.order_id = order_id
      self.site_id = config.site_id
      self.shop_id = config.shop_id
      self.member_pass_string = member_check_string(member_id: member_id, order_id: order_id, timestamp: datetime)
    end
  end
end
