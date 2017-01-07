module ServiceDecorator
  extend ActiveSupport::Concern

  included do |klass|
    klass.send(:include, ActionView::Helpers::NumberHelper)
  end

  def title
    "#{I18n.locale == :en ? name_en : name}(#{charge_type_text}/#{number_to_currency(amount, format: '%u%n', unit: '\\')})"
  end
end