module WeekdayBusinessHourDecorator
  extend ActiveSupport::Concern

  included do |klass|
  end

  def wday_name
    wday.present? && I18n.t(:abbr_day_names, scope: [:date])[wday]
  end
end
