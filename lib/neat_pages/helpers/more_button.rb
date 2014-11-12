#*************************************************************************************
# More button will generate a button that will load a page of items and append it
# to the current results
#*************************************************************************************
class NeatPages::Helpers::MoreButton < NeatPages::Helpers::Builder
  delegate :next?,          to: :pagination
  delegate :next_page,      to: :pagination
  delegate :paginated?,     to: :pagination
  delegate :total_pages,    to: :pagination

  def generate(label=nil, message_over=nil)
    return '' if not paginated? or not next?

    label = t('more') if not label
    message_over = t('over') if not message_over

    reset_builder

    b '<div id="neat-pages-more-button" data-next-page="' + next_page.to_s + '" data-total-pages="' + total_pages.to_s + '">'
    b '<a href="' + path_to(next_page) + '">' + label.to_s + '</a>'
    b '<div class="over">' + message_over.to_s + '</div>'
    b '</div>'

    b
  end
end
