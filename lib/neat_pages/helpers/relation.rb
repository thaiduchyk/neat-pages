#*************************************************************************************
# Relation will generate the HTML tag in the header that specify the page relationships.
#
# Output Example
#
# <link rel="next" href="http://www.example.com/product?sort=rating&page=2" />
#*************************************************************************************
class NeatPages::Helpers::Relation < NeatPages::Helpers::Builder
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

    link_rel_to previous_page, 'prev' if previous?
    link_rel_to next_page, 'next' if next?

    return b
  end

  private

  def link_rel_to(page_no, rel_tag)
    b '<link rel="' + rel_tag + '" href="' + path_to(page_no) + '"/>' + "\n"
  end

end
