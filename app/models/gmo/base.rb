module Gmo
  class Base < ApplicationModel
    attr_accessor :link

    delegate :config, :param_name, to: :link

    def initialize(link: nil)
      self.link = link || Payment.service(:gmo).link.about(self.class.name.demodulize.sub(/Response$/, '').underscore)
    end
  end
end
