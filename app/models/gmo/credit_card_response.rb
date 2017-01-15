module Gmo
  class CreditCardResponse < Response
    attr_accessor :site_id, :shop_id, :member_id, :datetime

    def initialize(member_id:, **options)
      super(options)
      self.site_id = config.site_id
      self.shop_id = config.shop_id
      self.member_id = member_id
    end

    def response_valid?
      check_string == link.response_check_string(member_id: member_id, datetime: datetime)
    end
  end
end
