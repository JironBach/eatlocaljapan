json.array!(@ngevents) do |event|
  json.merge! \
    start: event.start,
    end: event.holiday? ? event.end.tomorrow.beginning_of_day : event.end,
    title: I18n.t(event.reason, start: I18n.l(event.start, format: :hours), end: I18n.l(event.end, format: :hours), scope: [:alerts, :listing_ngevents, :reason]),
    color: Settings.listing_ngevents.color[event.reason],
    allDay: true,
    startWas: event.start,
    endWas: event.holiday? ? event.end.tomorrow.beginning_of_day : event.end,
    editingUrl: listing_listing_ngevent_path(event.listing, event),
    deletionUrl: listing_listing_ngevent_path(event.listing, event)
  json.extract! event, :id
end
