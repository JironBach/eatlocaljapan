module Gmo
  class CreditCard < Request
    attr_accessor :site_id, :shop_id, :member_id, :member_pass_string

    def initialize(member_id:, **options)
      super(options)
      self.site_id = config.site_id
      self.shop_id = config.shop_id
      self.member_id = member_id
      self.member_pass_string = link.member_check_string(member_id: member_id, timestamp: datetime)
    end

    class << self
      def about(member_id:)
        api = Payment.service(:gmo).api(:site)
        api.search_card(member_id: member_id, seq_mode: 1).each_with_object([]) do |(key, values), result|
          values.split(/\|/, -1).each_with_index { |value, index| (result[index] ||= {})[key.underscore.to_sym] = value }
        end
      end
    end
  end
end
