require 'active_support/core_ext/hash'
require 'active_support/core_ext/string'

class Payment
  class Base
    extend ActiveSupport::Autoload

    attr_accessor :transaction_id

    class << self
      def config
        Payment.config
      end
    end

    def config
      self.class.config
    end
  end
end
