class NeatPages::Helpers::Status < NeatPages::Helpers::Builder
  def generate
    return '' if empty? or out_of_bound?

    from, to = get_from_to_data

    return build_status from, to
  end

  def build_status(from, to)
    reset_builder

    b '<span data-neat-pages-control="status" id="neat-pages-status">'
    b "<span class=\"from\">#{from+1}</span>"
    b " #{t('to')} "
    b "<span class=\"to\">#{to}</span>/"
    b "<span class=\"total\">#{total_items}</span>"
    b '</span>'

    return b
  end

  def get_from_to_data
    from = offset
    to = from + per_page
    to = total_items if to > total_items

    return [from, to]
  end
end
