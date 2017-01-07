class Payment
  class Gmo
    class Site < Base
      def initialize(id:, pass:, host:)
        self.api = GMO::Payment::SiteAPI.new(site_id: id, site_pass: pass, host: host)
      end

      def with_transaction
        self.transaction_id = SercureRandom.hex(32)
        api.entry_tran
        yield
        api.exec_tran
      end
    end
  end
end
