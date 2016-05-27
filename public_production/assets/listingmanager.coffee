#ajax
$ ->

  $('#listing-manager-listing-image-submit').on 'click', ->
    postData = $(this).serializeArray()
    postData.append('listing_image[image]', $input[0].files[0]);
    formURL = $(this).attr('action')
    console.log postData
    console.log formURL
    $.ajax
      url: formURL
      type: $(this).attr('method')
      data: postData
      #data: new FormData($("#new_form")[0])
      processData: false
      contentType: false
      success: (data, textStatus, jqXHR) ->
        alert I18n.t('js.listingmanager.listing_image.submit.alert.success')
      error: (jqXHR, textStatus, errorThrown) ->
        alert I18n.t('js.listingmanager.listing_image.submit.alert.failure')
      complete:
        console.log 'upload complete'

  $('#listing-manager-listing-submit').on 'click', ->
    postData = $(this).serializeArray()
    formURL = $(this).attr('action')
    console.log postData
    console.log formURL
    $.ajax
      url: formURL
      type: $(this).attr('method')
      data: postData
      success: (data, textStatus, jqXHR) ->
        alert I18n.t('js.listingmanager.listing.submit.alert.success')
      error: (jqXHR, textStatus, errorThrown) ->
        alert I18n.t('js.listingmanager.listing.submit.alert.failure')
      complete:
        console.log 'update complete'

  $('#listing-manager-confection-submit').on 'click', ->
    postData = $(this).serializeArray()
    formURL = $(this).attr('action')
    console.log postData
    console.log formURL
    $.ajax
      url: formURL
      type: $(this).attr('method')
      data: postData
      success: (data, textStatus, jqXHR) ->
        alert I18n.t('js.listingmanager.confection.submit.alert.success')
      error: (jqXHR, textStatus, errorThrown) ->
        I18n.t('js.listingmanager.confection.submit.alert.failure')
      complete:
        console.log 'update complete'

  $('#listing-manager-tool-submit').on 'click', ->
    postData = $(this).serializeArray()
    formURL = $(this).attr('action')
    console.log postData
    console.log formURL
    $.ajax
      url: formURL
      type: $(this).attr('method')
      data: postData
      success: (data, textStatus, jqXHR) ->
        alert I18n.t('js.listingmanager.tool.submit.alert.success')
      error: (jqXHR, textStatus, errorThrown) ->
        alert I18n.t('js.listingmanager.tool.submit.alert.failure')
      complete:
        console.log 'update complete'

  $('#listing-manager-dress-code-submit').on 'click', ->
    postData = $(this).serializeArray()
    formURL = $(this).attr('action')
    console.log postData
    console.log formURL
    $.ajax
      url: formURL
      type: $(this).attr('method')
      data: postData
      success: (data, textStatus, jqXHR) ->
        alert I18n.t('js.listingmanager.dress_code.submit.alert.success')
      error: (jqXHR, textStatus, errorThrown) ->
        alert I18n.t('js.listingmanager.dress_code.submit.alert.failure')
      complete:
        console.log 'update complete'

  $('#listing-manager-open').on 'click', ->
    postData = $(this).serializeArray()
    formURL = $(this).attr('action')
    console.log postData
    console.log formURL
    $.ajax
      url: formURL
      type: $(this).attr('method')
      data: postData
      success: (data, textStatus, jqXHR) ->
        alert I18n.t('js.listingmanager.publish.submit.alert.success')
      error: (jqXHR, textStatus, errorThrown) ->
        alert I18n.t('js.listingmanager.publish.submit.alert.failure')
      complete:
        console.log 'update complete'
