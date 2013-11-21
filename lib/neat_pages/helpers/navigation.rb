#*************************************************************************************
# Navigation take care of generating the html code for the pagination navigation.
#
# Output Example
#
# < Previous | 1 | 2 | 3 | Next >
#*************************************************************************************
class NeatPages::Helpers::Navigation < NeatPages::Helpers::Builder
  delegate :current_page,   to: :pagination
  delegate :next?,          to: :pagination
  delegate :next_page,      to: :pagination
  delegate :paginated?,     to: :pagination
  delegate :previous?,      to: :pagination
  delegate :previous_page,  to: :pagination
  delegate :total_pages,    to: :pagination

  def generate
    return '' if not paginated?

    reset_builder

    navigation_standard
  end

  private

  def link_to(label, no_page, options={})
    options = { class: '' }.merge(options)

    attributes = { "data-page" => no_page }
    attributes["href"] = (no_page == '#' ? '#' : path_to(no_page))
    attributes["class"] = options[:class] if not options[:class].blank?

    return "<a " + attributes.map{ |k,v| "#{k}=\"#{v}\"" }.join(" ") + ">#{label}</a>"
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

    li(content, "move #{direction} #{list_class}")
  end

  def navigation_link(direction)
    link_to(navigation_label(direction), send("#{direction}_page"), class: direction)
  end

  def navigation_page_items(nbr_items=10)
    start, finish = get_bounds_of_pages nbr_items

    (1..total_pages).each do |i|
      hidden = (i < start or i > finish)
      if current_page == i
        li link_to_page(i), 'page selected'
      else
        li link_to_page(i), 'page', hidden: hidden
      end
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

  def get_bounds_of_pages(nbr_items)
    half_nbr_items = nbr_items / 2

    start = current_page > half_nbr_items ? (current_page - half_nbr_items + 1) : 1
    finish = current_page >= total_pages - half_nbr_items ? total_pages : (start + nbr_items - 1)
    start = (finish - nbr_items + 1) if start - finish < nbr_items
    start = 1 if start < 1

    return [start, finish]
  end

end
