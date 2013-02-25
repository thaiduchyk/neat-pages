class NeatPages::Helpers::Navigation < NeatPages::Helpers::Builder
  def generate(options={})
    options = { format: :standard }.merge(options)

    return '' if not paginated?

    reset_builder

    return case options[:format]
      when :light then navigation_light
      else navigation_standard
    end
  end

  private

  def link_to(label, no_page, options={})
    options = { class: '' }.merge(options)

    url = (no_page == '#' ? '#' : path_to(no_page))

    return "<a href=\"#{url}\" data-page=\"#{no_page}\" class=\"#{options[:class]}\">#{label}</a>"
  end

  def link_to_page(no_page)
    link_to no_page, no_page
  end

  def navigation_attributes
    {
      "id" => "neat-pages-navigation",
      "data-neat-pages-control=" => "navigation",
      "data-per-page" => per_page,
      "data-total-items" => total_items,
      "data-total-pages" => total_pages
    }.map{ |k,v| "#{k}=\"#{v}\"" }.join(' ')
  end

  def navigation_label(direction)
    (direction == 'next' ? "#{t('next_page')} &raquo;" : "&laquo; #{t('previous_page')}").html_safe
  end

  def navigation_list_link(direction, enabled)
    list_class = enabled ? '' : 'disabled'
    content = enabled ? navigation_link(direction) : link_to(navigation_label(direction), '#', class: direction)

    b li(content, "move #{direction} #{list_class}")
  end

  def navigation_light
    b '<ul class="light" ' + navigation_attributes + '>'
    navigation_list_link 'previous', previous?
    navigation_page_items(10)
    navigation_list_link 'next', next?
    b '</ul>'

    return b
  end

  def navigation_link(direction)
    link_to(navigation_label(direction), send("#{direction}_page"), class: direction)
  end

  def navigation_page_items(nbr_items=10)
    half_nbr_items = nbr_items / 2

    start = current_page > half_nbr_items ? (current_page - half_nbr_items + 1) : 1
    finish = current_page >= total_pages - half_nbr_items ? total_pages : (start + nbr_items - 1)
    start = (finish - nbr_items + 1) if start - finish < nbr_items
    start = 1 if start < 1

    (1..total_pages).each do |i|
      hidden = (i < start or i > finish)
      b (current_page == i ? li(link_to_page(i), 'page selected') : li(link_to_page(i), 'page', hidden))
    end
  end

  def navigation_standard
    b '<ul class="standard" ' + navigation_attributes + '>'
    navigation_list_link 'previous', previous?
    navigation_page_items(10)
    navigation_list_link 'next', next?
    b '</ul>'

    return b
  end

end
