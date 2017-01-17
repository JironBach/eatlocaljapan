#reservation, dashboard
$ ->

  $("[id^=reservation-item-show-receipt-]").on 'click', (e) ->
    alert I18n.t('js.reservation.receipt')
    e.preventDefault()

  $("[id^=reservation-item-as-guest-launch-message-]").on 'click', ->
    data_num = $(this).attr('data-num')
    $("#message-to-host-from-reservation-manager-" + data_num).modal()

  $("[id^=reservation-item-as-host-launch-message-]").on 'click', ->
    data_num = $(this).attr('data-num')
    $("#message-to-guest-from-reservation-manager-" + data_num).modal()

  # bootstrap datepicker
  $('.bookIt .bookIt__checkin.datepicker')
    .datepicker
      autoclose: true
      language: 'ja'
      clearBtn: true
      format : 'yyyy-mm-dd'
    .on 'click', (e)->
      date = if e.date then new Date(e.date) else new Date() 
      $.ajax
        type: 'GET'
        url: new URI(location.href).segmentCoded(['listings', $(@).data('listing-id'),date.getFullYear(), date.getMonth() + 1, 'closed_days']).href()
        dataType: 'json'
        success: (data)=>
          $(@).datepicker('setDaysOfWeekDisabled', data.w_days)
          $(@).datepicker('setDatesDisabled', data.dates)
        error: ->
      return true
    .on 'changeDate', (e)->
      date = if e.date then new Date(e.date) else new Date() 
      $.ajax
        type: 'GET'
        url: new URI(location.href).segmentCoded(['listings', $(@).data('listing-id'),date.getFullYear(), date.getMonth() + 1, date.getDate(), 'busy_times']).href()
        dataType: 'json'
        success: (data)->
          $('.bookIt .bookIt__checkinTime.timepicker').prop('disabled', false)
          $('.bookIt .bookIt__numOfPeople, .bookIt .bookIt__bookIt_submitButton').prop('disabled', true)
          [minTime, maxTime] = data.on_time
          $('.timepicker').timepicker('option',{
            'minTime': minTime
            'maxTime': maxTime
            'disableTimeRanges': data.times
            'wrapHours': false
          })
        error: ->
      return true
    .trigger 'changeDate'

  # timepicker
  $('.bookIt .bookIt__checkinTime.timepicker')
    .timepicker
      disableTimeRanges: []
      disableTextInput: true
    .on 'changeTime', (e)->
      time = moment($(@).val(), 'HH:mm')
      form = $(@).closest('form')
      date = form.find('.bookIt__checkin.datepicker').datepicker('getDate')
      date = if date then new Date(date) else new Date()
      # HACK: reconsider to replace by javascript base
      $.ajax
        type: 'GET'
        url: new URI(location.href).segmentCoded(['listings', $(@).data('listing-id'),date.getFullYear(), date.getMonth() + 1, date.getDate(), time.hour(), time.minute(), 'free_spaces']).href()
        dataType: 'json'
        success: (data)->
          if data.spaces <= 0
            $('.bookIt .bookIt__numOfPeople, .bookIt .bookIt__submitButton').prop('disabled', true)
          else
            numOfPeople = $('.bookIt .bookIt__numOfPeople')
            $('.bookIt .bookIt__numOfPeople, .bookIt .bookIt__submitButton').prop('disabled', false)
            numOfPeople.removeClass('disabled')
            numOfPeople.html('')
            for i in [1..data.spaces]
              numOfPeople.append($('<option>', {value: i, text: i}))
    .trigger 'changeTime'