module ChargeDecorator
  extend ActiveSupport::Concern

  included do |klass|
  end

  # rubocop:disable Rails/Delegate
  def title
    service.title
  end
  # rubocop:enable Rails/Delegate
end