module CreditCardDecorator
  extend ActiveSupport::Concern

  included do |klass|
  end

  def title
    card_no
  end
end
