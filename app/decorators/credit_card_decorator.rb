module CreditCardDecorator
  extend ActiveSupport::Concern

  included do |klass|
  end

  def title
    crushed_card_no
  end
end
