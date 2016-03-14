json.array!(@ngevents) do |event|
  json.merge! start: event.start, end: event.end + 1.second
  json.extract! event, :id
  # json.merge! title: I18n.t("alerts.listing_ngevents.reason.%{event.reason}")
  json.merge! title: I18n.t("alerts.listing_ngevents.reason.#{event.reason}")
  json.merge! color: Settings.listing_ngevents.color[event.reason]
  json.merge! allDay: true
end
