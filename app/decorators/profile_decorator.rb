module ProfileDecorator
  extend ActiveSupport::Concern

  included do |klass|
  end

  def full_name(locale: I18n.locale)
    I18n.t(:full_name, first_name: first_name, last_name: last_name, locale: locale)
  end
end