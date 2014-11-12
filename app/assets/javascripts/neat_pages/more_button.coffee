class NeatPagesMoreButton
  constructor: ->
    # AJAX pagination only for IE7 and up
    if navigator.appVersion.indexOf("MSIE 7.") == -1
      if $('#neat-pages-ajax-wrapper').length != 0
        @cachePage()

        $('#neat-pages-more-button a').click (e) => @moreItems($(e.target)); return false


  buildURL: () ->
    url = $('#neat-pages-more-button a').attr('href')
    url = url.replace('%5B', '[').replace('%5D', ']') # Make sure the array parameters won't be encoded twice. Careful before removing the encodeURI down there, it could create some bugs.

    if window.location.pathname is '/' or window.location.pathname is ''
      encodeURI(url + '&format=neatpage')
    else
      encodeURI(url.replace('?', '.neatpage?'))


  cachePage: () -> $.get(@buildURL(), (data) => @cache = data)

  emptyCache: () -> @cache = ''

  loadNextPage: () ->
    nextPage = $('#neat-pages-more-button').data('next-page')

    if @itemsLeft()
      nextURL = $('#neat-pages-more-button a').attr('href').replace('page=' + nextPage, 'page=' + (nextPage + 1))
      $('#neat-pages-more-button a').attr('href', nextURL)
      $('#neat-pages-more-button').data('next-page', nextPage + 1)
      @cachePage()


  moreItems: (button) ->
    @showPageContent()
    @triggerEvent()
    @emptyCache()
    @loadNextPage()


  itemsLeft: () -> $('#neat-pages-more-button').data('next-page') < $('#neat-pages-more-button').data('total-pages')

  showPageContent: () ->
    cacheHidden = $(@cache).hide()
    $('#neat-pages-ajax-wrapper').append cacheHidden
    cacheHidden.fadeIn 300

    if not @itemsLeft()
      $('#neat-pages-more-button a').hide()
      $('#neat-pages-more-button div.over').fadeIn 300


  triggerEvent: () ->
    noPage = $('#neat-pages-more-button').data('next-page')

    $('body').trigger('neat_pages:update', { noPage: noPage })

    if not @itemsLeft() then $('body').trigger('neat_pages:over')


$ -> new NeatPagesMoreButton if $('#neat-pages-more-button').length > 0
