module Gmo
  class Request < Base
    attr_accessor :url, :ret_url, :cancel_url, :datetime, :enc, :lang

    delegate :config, :param_name, to: :link

    def initialize(link: nil, datetime: Time.zone.now.to_s(:number), ret_url:, cancel_url: nil, enc: 'utf-8', lang: :ja)
      super(link: link)
      self.datetime = datetime
      self.ret_url = ret_url
      self.cancel_url = cancel_url
      self.enc = enc
      self.lang = lang
      self.url = self.link.endpoint
    end
  end
end
