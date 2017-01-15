class Payment
  class Gmo
    class Link
      class CheckCreditCard < Base
        class << self
          def endpoint
            Addressable::URI.parse(config.link_endpoint).join(File.join(config.shop_id, 'Multi', 'Entry')).normalize.to_s
          end

          def shop_check_string(order_id:, amount:, tax: nil, timestamp:)
            encode(*[config.shop_id, order_id, amount, tax, config.shop_key, timestamp].compact)
          end

          def member_check_string(member_id:, timestamp:)
            encode(config.site_id, member_id, config.site_key, timestamp)
          end

          def response_check_string(order_id:, forwarded:, method:, pay_times:, approve:, tran_id:, tran_date:)
            encode(*[order_id, forwarded, method, pay_times, approve, tran_id, tran_date, config.shop_key].compact)
          end
        end
      end
    end
  end
end
