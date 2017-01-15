class Payment
  class Gmo < Payment::Base
    autoload :Site
    autoload :Shop
    autoload :Link

    class << self
      def api(api=:site)
        const_get(api.to_s.classify).new(id: config[:"#{api}_id"], pass: config[:"#{api}_key"], host: config[:endpoint]).tap { |instance| yield(instance) if block_given? }
      end

      def link
        const_get('Link').tap { |klass| yield(klass) if block_given? }
      end
    end

    class Base < Payment::Base
      attr_accessor :api

      def respond_to_missing?(name, include_private)
        api&.method_defined?(name) || super
      end

      def method_missing(name, *args)
        api&.class&.method_defined?(name) && api.send(name, *args) || super
      end
    end
  end
end