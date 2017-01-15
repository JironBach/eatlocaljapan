class Payment
  class Gmo
    class Link
      class RegistCreditCard < Base
        class << self
          def endpoint
            Addressable::URI.parse(config.link_endpoint).join(File.join(config.shop_id, 'Member', 'Edit')).normalize.to_s
          end

          def member_check_string(member_id:, order_id:, timestamp:)
            encode(config.site_id, member_id, config.shop_id, order_id, config.site_key, config.shop_key, timestamp)
          end

          def response_check_string(member_id:, order_id:, datetime:)
            encode(config.site_id, member_id, config.shop_id, order_id, config.site_key, datetime)
          end
        end
      end
    end
  end
end
