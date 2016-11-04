json.array!(@ngevents) do |event|
  json.merge! \
    start: event.start,
    end: event.end + 1.second,
    title: I18n.t(event.reason, scope: [:alerts, :listing_ngevents, :reason]),
    color: Settings.listing_ngevents.color[event.reason],
    allDay: true
  json.extract! event, :id
end
