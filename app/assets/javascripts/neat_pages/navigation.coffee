class NeatPagesNavigation
  constructor: () ->
    # AJAX pagination only for IE7 and up
    if navigator.appVersion.indexOf("MSIE 7.") == -1
      if $('#neat-pages-ajax-wrapper').length != 0
        @initPagination()

        $(window).hashchange () => @loadPage @getPageFromHash()

        $('#neat-pages-navigation li.next a').click (e) => @nextPage() ; return false
        $('#neat-pages-navigation li.previous a').click (e) => @previousPage() ; return false
        $('#neat-pages-navigation li.page a').click (e) => @thatPage $(e.target) ; return false


  buildURL: (noPage) ->
    url = @getPage(noPage).attr('href')
    url = url.replace('%5B', '[').replace('%5D', ']') # Make sure the array parameters won't be encoded twice. Careful before removing the encodeURI down there, it could create some bugs.

    if window.location.pathname is '/' or window.location.pathname is ''
      encodeURI(url + '&format=neatpage')
    else
      encodeURI(url.replace('?', '.neatpage?'))


  cachePage: (noPage) -> $.get(@buildURL(noPage), (data) => @cachePages[noPage] = data)


  cacheNextPage: () ->
    noNextPage = @getPageFromHash() + 1

    @cachePage noNextPage if noNextPage < @totalPages() and not @pageIsCached noNextPage


  centerPages: () ->
    current = @currentPageNumber()
    totalPageLink = $('#neat-pages-navigation li.page:visible').length
    halfTotalPageLink = totalPageLink/2

    start = if current > halfTotalPageLink then current - halfTotalPageLink + 1 else 1
    finish = if current >= @totalPages() - halfTotalPageLink then @totalPages() else (start + totalPageLink - 1)
    start = (finish - totalPageLink + 1) if start - finish < totalPageLink - 1
    start = 1 if start < 1

    $('#neat-pages-navigation li.page').hide()
    @getPage(page).closest('li').show() for page in [start..finish]


  currentPage: () -> $('#neat-pages-navigation li.page.selected a')

  currentPageNumber: () -> Number(@currentPage().data('page'))

  getPage: (noPage) -> $('#neat-pages-navigation li.page a[data-page="' + noPage + '"]')

  getPageFromHash: () ->
    page = 1

    if location.hash.indexOf('page-') isnt -1
      selection = Number(location.hash.replace('#page-', ''))
      page = selection if selection > 0 and selection <= @totalPages()

    return page


  initPagination: () ->
    @cachePages = []
    @cachePages[@currentPageNumber()] = $('#neat-pages-ajax-wrapper').html()
    @cacheNextPage()

    # When starting from a page that is not 1. (EX: Press Refresh or Back)
    if @getPageFromHash() != 1
      $('#neat-pages-ajax-wrapper').hide()
      @loadPage @getPageFromHash()



  loadPage: (noPage) ->
    $('#neat-pages-ajax-wrapper').css( opacity: 0.5 )
    @updateNav Number(noPage)
    @updateStatus()

    if @pageIsCached noPage
      @updatePage @cachePages[noPage], noPage
      $('body').trigger('neat_pages:update', {noPage: noPage})
    else
      $.get(
        @buildURL(noPage), (data) => @updatePage data, noPage
      ).done(() ->
        $('body').trigger('neat_pages:update', {noPage: noPage})
      )

  moveIsDisabled: (direction) -> $('#neat-pages-navigation li.' + direction).hasClass('disabled')

  nextPage: () -> @updateHash @currentPageNumber() + 1 if not @moveIsDisabled 'next'

  pageIsCached: (noPage) -> if @cachePages[noPage] then true else false

  perPage: () -> Number($('#neat-pages-navigation').data('per-page'))

  previousPage: () -> @updateHash @currentPageNumber() - 1 if not @moveIsDisabled 'previous'

  thatPage: (link) -> @updateHash link.data('page') if not link.closest('li').hasClass('selected')

  totalItems: () -> Number($('#neat-pages-navigation').data('total-items'))

  totalPages: () -> Number($('#neat-pages-navigation').data('total-pages'))

  updateHash: (noPage) -> location.href = '#page-' + noPage

  updateNav: (noPage) ->
    $('#neat-pages-navigation li.page').removeClass('selected')
    @getPage(noPage).closest('li').addClass('selected')
    $('#neat-pages-navigation li.move').removeClass('disabled')

    if noPage <= 1
      $('#neat-pages-navigation li.previous').addClass('disabled')
      $('#neat-pages-navigation li.previous a').attr('href', '#')
    else
      $('#neat-pages-navigation li.previous a').attr('href', @getPage(noPage-1).attr('href'))

    if noPage >= @totalPages()
      $('#neat-pages-navigation li.next').addClass('disabled')
      $('#neat-pages-navigation li.next a').attr('href', '#')
    else
      $('#neat-pages-navigation li.next a').attr('href', @getPage(noPage+1).attr('href'))

    @centerPages()


  updatePage: (data, noPage) ->
    @cachePages[noPage] = data if not @pageIsCached noPage

    $('#neat-pages-ajax-wrapper').hide()
    $('#neat-pages-ajax-wrapper').css( opacity: 1 )
    $('#neat-pages-ajax-wrapper').html(data)
    $('#neat-pages-ajax-wrapper').fadeIn(300)
    $('body, html').animate({scrollTop : 0}, 0);

    $('#neat-pages-navigation').trigger 'change'

    @cacheNextPage()


  updateStatus: () ->
    from = ((@currentPageNumber()-1) * @perPage()) + 1
    to = from + @perPage() - 1
    to = @totalItems if to > @totalItems()

    $('#neat-pages-status').find('span.from').html(from)
    $('#neat-pages-status').find('span.to').html(to)


$ -> new NeatPagesNavigation if $('#neat-pages-navigation').length
