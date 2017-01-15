class Payment
  class Gmo
    class Link
      class CreditCard < Base
        class << self
          def endpoint
            Addressable::URI.parse(config.link_endpoint).join(File.join(config.shop_id, 'Member', 'Edit')).normalize.to_s
          end

          def member_check_string(member_id:, timestamp:)
            encode(config.site_id, member_id, config.shop_id, config.site_key, timestamp)
          end

          def response_check_string(member_id:, datetime:)
            encode(config.site_id, member_id, config.shop_id, config.site_key, datetime)
          end
        end
      end
    end
  end
end
