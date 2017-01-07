class Payment
  class Gmo
    class Shop < Base
      def initialize(id:, pass:, host:)
        self.api = GMO::Payment::ShopAPI.new(shop_id: id, shop_pass: pass, host: host)
      end
    end
  end
end
