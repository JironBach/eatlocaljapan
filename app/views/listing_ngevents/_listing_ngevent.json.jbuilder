json.(listing_ngevent, :id)
json.merge! \
  start: listing_ngevent.start,
  end: listing_ngevent.holiday? ? listing_ngevent.end.tomorrow.beginning_of_day : listing_ngevent.end,
  title: listing_ngevent.holiday? ? I18n.t(listing_ngevent.reason, scope: [:alerts, :listing_ngevents, :reason]) : '',
  color: Settings.listing_ngevents.color[listing_ngevent.reason],
  allDay: listing_ngevent.holiday?,
  startWas: listing_ngevent.start,
  endWas: listing_ngevent.holiday? ? listing_ngevent.end.tomorrow.beginning_of_day : listing_ngevent.end,
  editingUrl: listing_listing_ngevent_path(listing_ngevent.listing, listing_ngevent),
  deletionUrl: listing_listing_ngevent_path(listing_ngevent.listing, listing_ngevent)
