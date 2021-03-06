#listings.coffee
$ ->
  # listings#new
  if $('body').hasClass('listings new')

    # add input file for pics
    $('.add-file-input').on 'click', ->
      $(this).before('<input type="file">')
      return false

    # disabled submit-btn to active
    $('#new_listing input[type="text"]').on 'blur', ->
      if $('#listing_title').val() != '' && $('#listing_zipcode').val() != '' && $('#listing_location').val() != ''
        $('.btn-primary').removeClass('disabled')

  # confections#manage, tools#manage
  if $('body').hasClass('confections manage') || $('body').hasClass('tools manage')
    $('form.url-check').validate
      rules:
        'tool[url]':
          required: false
          url: true
      messages: 'tool[url]':
        url: I18n.t('js.listings.manage.url')

  # listings#search
  if $('body').hasClass('listings search')
    # sp filter toggle
    $('.js-small-filter-toggle').on 'click', ->
      $(this).addClass('hide')
      $('.no-listings-block').hide()
      $('.sidebar').addClass('filters-open')
      $('body').scrollTop(0)
    $('.js-small-filters-close').on 'click', ->
      $('.js-small-filter-toggle').removeClass('hide')
      $('.sidebar').removeClass('filters-open')
      $('.no-listings-block').show()

    # sidebar header switch
    setTimeout (->
      bodyHeight = $('body').outerHeight()
      sidebarHeader = $('.sidebar-header')
      stickyNavTop = $('.sidebar-header').position().top
      stickyHead = ->
        scrollTop = $('.sidebar').scrollTop()
        if scrollTop > stickyNavTop
          $('body').addClass('stuck')
          $('.sidebar').before(sidebarHeader)
          $('.sidebar-placeholder').removeClass 'hide'
        else
          $('.filters').after(sidebarHeader)
          $('body').removeClass('stuck')
          $('.sidebar-placeholder').addClass 'hide'
        return

      checkSize = ->
        if $('footer').css('display') == 'block'
          scrollTop = $('body').scrollTop()
          bodyHeight = $('body').outerHeight()
          footerHeight = $('footer').outerHeight()
          footerPosi = $('.results-footer').offset().top
          winHeight = $(window).outerHeight()
          tempPosi = bodyHeight - winHeight - footerHeight - 90
          tempPosi2 = footerPosi - 50

          if scrollTop >= tempPosi && bodyHeight >= winHeight
            $('.filters-btn').removeClass('fixed').addClass('bottom').css('top', tempPosi2)
          else
             $('.filters-btn').addClass('fixed').removeClass('bottom').removeAttr('style')
        else
        return

      stickyHead()
      checkSize()

      $('.sidebar').scroll ->
        stickyHead()
        return

      $(window).scroll ->
        checkSize()
        return

      # window resize
      timer = false
      $(window).resize ->
        if timer != false
          clearTimeout timer
        timer = setTimeout((->
          stickyHead()
          checkSize()
          return
        ), 200)
        return
    ), 300

    # wishlist modal
    $('.wishlist-button label').on 'click', ->
      $('#modal-wishlist').modal()

    $('#hogehogehogehoge').on 'click', ->
      $('#modal-wishlist').modal()

    # bootstrap datepicker
    $('.datepicker').datepicker
      orientation: 'bottom right'

    # range slider
    $("#price-range").slider
      min: 0
      max: 100000
      step: 100
      range: true
      value: [500, 50000]
      tooltip: 'always'
      tooltip_split: true
      handle: 'square'

    # filter open-close
    sidebarHeight = $('.sidebar').outerHeight()
    filtersHeight = $('.filters.collapse').outerHeight()
    tempHeight = sidebarHeight - filtersHeight
    $('.filters').css 'bottom', tempHeight + 'px'
    $('.filters-placeholder').height filtersHeight + 'px'

    $('.show-filters').on 'click', ->
      $('.filters-placeholder').removeClass('hide')
      $('.filters').animate {bottom: '0px'}, 300
      $('.filters').removeClass('collapse')
      $('.sidebar-header').addClass('transparent')
      setTimeout (->
        $('.sidebar').addClass('filters-open')
      ), 500

    $('.search-button').on 'click', ->
      $('.sidebar').removeClass('filters-open')
      $('.filters').animate {bottom: tempHeight + 'px'}, 300
      setTimeout (->
        $('.sidebar-header').removeClass('transparent')
        $('.filters-placeholder').addClass('hide')
        $('.filters').addClass('collapse')
      ), 500

    # circle map
    cityCircle = undefined

    initialize = ->
      bounds = new google.maps.LatLngBounds()
      mapOptions =
        scrollwheel: false
        zoom: 15
        center: new (google.maps.LatLng)(gon.listings[0].latitude, gon.listings[0].longitude)
        mapTypeId: google.maps.MapTypeId.TERRAIN

      map = new (google.maps.Map)(document.getElementById('map'), mapOptions)

      # Multiple Markers
      # Info Window Content
      markers = new Array()
      infoWindowContent = new Array()
      gon.listings.map (l) ->
        tmp_marker = new Array()
        tmp_info = new Array()
        tmp_marker.push(l.title, l.latitude, l.longitude)
        markers.push(tmp_marker)
        tmp_info.push('<div class="info_content"><img src="' + l.cover_image.thumb.url + '"><h3>' + l.title + '</h3><p>' + l.description  + '</p></div>')
        infoWindowContent.push(tmp_info)

      # Display multiple markers on a map
      infoWindow = new google.maps.InfoWindow()

      # Loop through our array of markers & place each one on the map
      i = 0
      while i < markers.length
        position = new (google.maps.LatLng)(markers[i][1], markers[i][2])
        bounds.extend position
        marker = new (google.maps.Marker)(
          position: position
          map: map
          title: markers[i][0])
        # Allow each marker to have an info window
        google.maps.event.addListener marker, 'click', do (marker, i) ->
          ->
           infoWindow.setContent infoWindowContent[i][0]
           infoWindow.open map, marker
           return
        # Automatically center the map fitting all markers on the screen
        map.fitBounds bounds
        i++

        # Override our map zoom level once our fitBounds function runs (Make sure it only runs once)
        #boundsListener = google.maps.event.addListener(map, 'bounds_changed', (event) ->
        #  @setZoom 14
        #  google.maps.event.removeListener(boundsListener)
        #  return
        #)

    google.maps.event.addDomListener window, 'load', initialize

  # listings#show
  if $('body').hasClass('listings show')

    # message-host-link-subnav
    $('#message-host-link-subnav').on 'click', ->
      $('.bookIt__checkin').focus()

    # responsive request-block moving
    requestMove = ->
      wrap = if $('#request-btn-fixed').css('display') == 'block' then $('.bookIt__modal_size_sm') else $('.bookIt').not('.bookIt__modal_size_sm')
      wrap.siblings().not(wrap).remove()

    requestMove()
    # window resize
    timer = false
    $(window).resize ->
      if timer != false
        clearTimeout timer
      timer = setTimeout((->
        requestMove()
        return
      ), 100)
      return

    # book_it_button action
    $('.bookIt .bookIt__submitButton').on 'click', ->
      if $('.bookIt__checkin').val() == ''
        $('.bookIt__checkin').datepicker('show')
        return false
      else if $('.bookIt .bookIt__checkinTime.timepicker').val() == ''
        $('.bookIt .bookIt__checkinTime.timepicker').timepicker('show')
        return false

    # share-via-email modal
    $('#share-via-email-trigger').on 'click', ->
      $('#share-via-email').modal()

    #scrollspy
    scrollMenu = ->
      array =
        '#summary': 0
        '#neighborhood': 0
      $globalNavi = new Array
      for key of array
        if $(key).offset()
          array[key] = $(key).offset().top - 10
          $globalNavi[key] = $('.subnav-list li a[href="' + key + '"]')
      # スクロールイベントで判定
      for key of array
        if $(window).scrollTop() > array[key]
          $('.subnav-list li a').each ->
            $(this).attr 'aria-selected', false
            return
          $globalNavi[key] .attr 'aria-selected', true
      return

    setTimeout (->
      scrollMenu()
    ), 100

    $(window).scroll ->
      scrollMenu()
      return

    # circle map
    cityCircle = undefined

    initialize = ->
      if $('html').hasClass('touch')
        mapOptions =
          scrollwheel: false
          draggable: false
          zoom: 15
          center: new (google.maps.LatLng)(gon.listing.latitude, gon.listing.longitude)
          mapTypeId: google.maps.MapTypeId.TERRAIN
      else
        mapOptions =
          scrollwheel: false
          zoom: 15
          center: new (google.maps.LatLng)(gon.listing.latitude, gon.listing.longitude)
          mapTypeId: google.maps.MapTypeId.TERRAIN

      map = new (google.maps.Map)(document.getElementById('map'), mapOptions)

      marker = new google.maps.Marker
        position: new (google.maps.LatLng)(gon.listing.latitude, gon.listing.longitude)
        map: map

      circleOptions =
        strokeColor: '#17AEDF'
        strokeOpacity: 0.8
        strokeWeight: 1
        fillColor: '#17AEDF'
        fillOpacity: 0.35
        map: map
        #center: new (google.maps.LatLng)(43.051645, 141.384605)
        center: new (google.maps.LatLng)(gon.listing.latitude, gon.listing.longitude)
        radius: Math.sqrt(100) * 50
      # Add the circle for this city to the map.
      cityCircle = new (google.maps.Circle)(circleOptions)
      return

    google.maps.event.addDomListener window, 'load', initialize

    # carousel
    if $('.carousel-item').length > 1
      singleCol = $('.carousel-item').outerWidth()
      colCount = $('.carousel-item').length
      tempCount = 1
      currentPos = undefined

      $('.carousel-chevron.right').removeClass('hide')
      $('.listings-container').width(singleCol * colCount)

      # click next
      $('.carousel-chevron.right').on 'click', ->
        currentPos = singleCol * tempCount
        $('.listings-container').css('left', '-' + currentPos + 'px')
        tempCount++

        $('.carousel-chevron.left').removeClass('hide')
        if(colCount <= 2)
          $('.carousel-chevron.right').addClass('hide')
        if(colCount == tempCount)
          $('.carousel-chevron.right').addClass('hide')

      # click prev
      #$('.carousel-chevron.left').on 'click', ->
      #  currentPos = currentPos - singleCol
      #  $('.listings-container').css('left', '-' + currentPos + 'px')
      #  tempCount--

      #  if(tempCount <= 1)
      #    $('.carousel-chevron.left').addClass('hide')
      #    $('.carousel-chevron.right').removeClass('hide')

      #click photo
      #$('#photos').find('.photo-slider-item').modalSlider({
      #  type: 'image',
      #   gallery: {
      #    enabled: true,
      #    navigateByImgClick: true
      #  },
      #  image: {titleSrc: 'title'}
      #})

  # manage height equlizer
  if $('.manage-listing-nav').length && !$('body').hasClass('listing_ngevents')
    mContainerHeight = $('.manage-listing-content').outerHeight()
    setHeight = ->
      headerHeight = $('.common-header').outerHeight()
      mHeaderHeight = $('.manage-listing-header').outerHeight()
      winHeight = $(window).outerHeight()
      tempHeight1 = mContainerHeight + headerHeight + mHeaderHeight
      tempHeight2 = winHeight - (headerHeight + mHeaderHeight)
      if winHeight >= tempHeight1
        $('.manage-listing-content').css 'height', tempHeight2
      return
    setHeight()
    # window resize
    timer = false
    $(window).resize ->
      if timer != false
        clearTimeout timer
      timer = setTimeout((->
        setHeight()
        return
      ), 200)
      return

  $('.listing__listingsShopCategories .listing__listingsShopCategories__activeCheckbox, .listing__listingsShopServices .listing__listingsShopServices__activeCheckbox, .listing__englishesListings .listing__englishesListings__activeCheckbox, .listing__englishMessagesListings .listing__englishMessagesListings__activeCheckbox').on 'change', (e) ->
    $(@).closest('label').find('input[type="hidden"][name*="[_destroy]"]').val(not $(@).prop('checked'))
