$ ->
  $('.listingNgevent #calendar').fullCalendar(
    header: {
      left: 'today prev,next title',
      center: '',
      right: ''
    },
    defaultView: 'month',
    # 時間の書式
    timeFormat: 'H(:mm)',
    # 列の書式
    columnFormat: {
        month: 'ddd',    # 月
        week: "d'('ddd')'", # 7(月)
        day: "d'('ddd')'" # 7(月)
    },
    # タイトルの書式
    titleFormat: {
        month: I18n.t('js.calendar.title_format.month'), # 2013年9月
        week: I18n.t('js.calendar.title_format.week'),   # 2013年9月7日 ～ 13日
        day: I18n.t('js.calendar.title_format.day')      # 2013年9月7日(火)
    },
    buttonText: {
      # prev: '',
      # next: '',
      prevYear: ' << ',
      nextYear: ' >> ',
      today: I18n.t('js.calendar.button_text.today'),
      month: I18n.t('js.calendar.button_text.month'),
      week: I18n.t('js.calendar.button_text.week'),
      day: I18n.t('js.calendar.button_text.day')
    },
    # 月名称
    monthNames: [
      I18n.t('js.calendar.month_names.jan'), I18n.t('js.calendar.month_names.feb'), I18n.t('js.calendar.month_names.mar'),
      I18n.t('js.calendar.month_names.apr'), I18n.t('js.calendar.month_names.may'), I18n.t('js.calendar.month_names.jun'),
      I18n.t('js.calendar.month_names.jul'), I18n.t('js.calendar.month_names.aug'), I18n.t('js.calendar.month_names.sep'),
      I18n.t('js.calendar.month_names.oct'), I18n.t('js.calendar.month_names.nov'), I18n.t('js.calendar.month_names.dec')
    ],
    # 月略称
    monthNamesShort: [
      I18n.t('js.calendar.month_names_short.jan'), I18n.t('js.calendar.month_names_short.feb'), I18n.t('js.calendar.month_names_short.mar'),
      I18n.t('js.calendar.month_names_short.apr'), I18n.t('js.calendar.month_names_short.may'), I18n.t('js.calendar.month_names_short.jun'),
      I18n.t('js.calendar.month_names_short.jul'), I18n.t('js.calendar.month_names_short.aug'), I18n.t('js.calendar.month_names_short.sep'),
      I18n.t('js.calendar.month_names_short.oct'), I18n.t('js.calendar.month_names_short.nov'), I18n.t('js.calendar.month_names_short.dec')
    ],
    # 曜日名称
    dayNames: [
      I18n.t('js.calendar.day_names.sun'), I18n.t('js.calendar.day_names.mon'), I18n.t('js.calendar.day_names.tue'),
      I18n.t('js.calendar.day_names.wed'), I18n.t('js.calendar.day_names.thu'), I18n.t('js.calendar.day_names.fri'),
      I18n.t('js.calendar.day_names.sat')
    ],
    # 曜日略称
    dayNamesShort: [
      I18n.t('js.calendar.day_names_short.sun'), I18n.t('js.calendar.day_names_short.mon'), I18n.t('js.calendar.day_names_short.tue'),
      I18n.t('js.calendar.day_names_short.wed'), I18n.t('js.calendar.day_names_short.thu'), I18n.t('js.calendar.day_names_short.fri'),
      I18n.t('js.calendar.day_names_short.sat')
    ],
    contentHeight: 500,
    slotEventOverlap: false,
    events: "#{if I18n.locale == 'ja' then '' else '/en/'}#{$('.listingNgevent #calendar').data('actionUrl').replace(/\/$/, '')}.json",
    selectable: true,
    selectHelper: true,
    ignoreTimezone: false,
    editable: true,
    select: (start, end, event, view) ->
      calendar = $(@).closest('#calendar')
      unless calendar.data('deleteMode')
        modal = $('.listingNgevent__calendar__selectModal')
        modal.data('start', start)
        modal.data('end', end)
        $.each [['year', 0], ['month', 1], ['date', 0]], (index, info) ->
          modal.find("input[type='hidden'][name*='start(#{index + 1}i)']").val(start[info[0]]() + info[1])
          modal.find("input[type='hidden'][name*='end(#{index + 1}i)']").val(end[info[0]]() + info[1])
        modal.modal('show')
    eventClick: (event, jsEvent, view) ->
      calendar = $(@).closest('#calendar')
      unless calendar.data('deleteMode')
        calendar.fullCalendar 'refetchEvents'
      else
        if confirm(I18n.t('js.calendar.remove_event.alert'))
          $.ajax
            type: 'DELETE',
            url: event.deletionUrl,
            dataType: 'json',
            complete: -> calendar.fullCalendar 'refetchEvents'
    eventResize: (event, delta, revertFunc, jsEvent, ui, view) ->
      calendar = $(@).closest('#calendar')
      $.ajax
        type: 'PUT'
        url: event.editingUrl
        data: {event: {end: moment(event.endWas).add(delta)._d}}
        dataType: 'json'
        complete: -> calendar.fullCalendar 'refetchEvents'
    eventDrop: (event, delta, revertFunc, jsEvent, ui, view) ->
      calendar = $(@).closest('#calendar')
      $.ajax
        type: 'PUT'
        url: event.editingUrl
        data: {event: {start: moment(event.startWas).add(delta)._d, end: moment(event.endWas).add(delta)._d}}
        dataType: 'json'
        complete: -> calendar.fullCalendar 'refetchEvents'
  )

  $('.listingNgevent__calendar .listingNgevent__calendar__selectModal .listingNgevent__calendar__selectModal__selectDayButton').on 'click', (e)->
    modal = $(@).closest('.modal')
    calendar = modal.closest('#calendar')
    form = modal.find('form')
    modal.modal('hide')
    $.ajax
      type: 'POST'
      url: form.prop('action')
      data: form.serialize()
      dataType: 'json'
      complete: -> calendar.fullCalendar 'refetchEvents'

  $('.listingNgevent__calendar .listingNgevent__calendar__selectModal .listingNgevent__calendar__selectModal__selectTimeButton').on 'click', (e)->
    modal = $('.listingNgevent .listingNgevent__timeModal')
    start = $(@).closest('.modal').data('start')
    $.each [['year', 0], ['month', 1], ['date', 0]], (index, info) ->
      modal.find("input[type='hidden'][name*='start(#{index + 1}i)']").val(start[info[0]]() + info[1])
      modal.find("input[type='hidden'][name*='end(#{index + 1}i)']").val(start[info[0]]() + info[1])
    modal.find('select[name*="start(4i)"]').val('12')
    modal.find('select[name*="end(4i)"]').val('13')
    modal.find('select[name*="(5i)"]').val('00')
    modal.modal 'show'

  $('.listingNgevent .listingNgevent__timeModal .listingNgevent__timeModal__registrationButton').on 'click', (e)->
    calendar = $('.listingNgevent #calendar')
    modal = $(@).closest('.modal')
    form = modal.find('form')
    modal.modal('hide')
    $.ajax
      type: 'POST'
      url: form.prop('action')
      data: form.serialize()
      dataType: 'json'
      success: -> calendar.find('.modal').modal('hide')
      complete: -> calendar.fullCalendar 'refetchEvents'

  # delete_btn
  $('.listingNgevent #calendar').data('deleteMode', false)
  $(document).on 'click', '.listingNgevent__deleteMode', ->
    calendar = $('.listingNgevent #calendar')
    $(@).empty()
    if calendar.data('deleteMode') == false
      $(@).append('<button id="no_delete">' + I18n.t('js.calendar.delete_button.on_mode.label') + '</button>')
      $('.fc-toolbar').append("<div class='calendar-alert'>#{I18n.t('js.calendar.delete_button.on_mode.alert')}</div>")
      $('.fc-view-container').addClass('delete-mode')
      calendar.data('deleteMode', true)
    else
      $(@).append("<button id='delete_btn'>#{I18n.t('js.calendar.delete_button.off_mode.label')}</button>")
      $('.fc-view-container').removeClass('delete-mode')
      $('.calendar-alert').remove()
      calendar.data('deleteMode', false)
