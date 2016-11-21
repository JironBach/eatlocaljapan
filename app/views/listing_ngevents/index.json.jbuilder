json.array!(@ngevents) do |event|
  json.merge! \
    start: event.start,
    end: event.holiday? ? event.end.tomorrow.beginning_of_day : event.end,
    title: event.holiday? ? I18n.t(event.reason, scope: [:alerts, :listing_ngevents, :reason]) : '',
    color: Settings.listing_ngevents.color[event.reason],
    allDay: event.holiday?,
    startWas: event.start,
    endWas: event.holiday? ? event.end.tomorrow.beginning_of_day : event.end,
    editingUrl: listing_listing_ngevent_path(event.listing, event),
    deletionUrl: listing_listing_ngevent_path(event.listing, event)
  json.extract! event, :id
end
