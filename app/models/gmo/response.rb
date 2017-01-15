module Gmo
  class Response < Base
    attr_accessor :check_string, :err_code, :err_info

    delegate :config, :response_check_string, :attribute_mappings, :attribute_name, to: :link

    def initialize(link: nil)
      super(link: link)
    end

    def errors
      err_code.split(/\|/, -1).zip(err_info.split(/\|/, -1)).map { |(code, info)| [code, info].join(':') }
    end

    def response_valid?
      raise NotImplementedError.new('response_valid? must implement in concrete class.')
    end

    def valid?
      response_valid? && errors.empty?
    end
  end
end
