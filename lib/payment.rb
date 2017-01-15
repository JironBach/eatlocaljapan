require 'active_support'
require 'active_support/configurable'
require 'addressable/uri'

class Payment
  extend ActiveSupport::Autoload
  include ActiveSupport::Configurable

  autoload :Base
  autoload :Gmo

  config_accessor :service, :endpoint, :link_endpoint, :site_id, :site_key, :shop_id, :shop_key

  class << self
    def service(service=:gmo)
      const_get(service.to_s.classify).tap { |klass| yield(klass) if block_given? }
    end
  end
end
