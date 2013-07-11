module NeatPages::Helpers
  def neat_pages_ajax_items(partial_path, options={})
    ('<div id="neat-pages-ajax-wrapper" class="first-load">' + render(partial_path, options) + '</div>').html_safe
  end

  def neat_pages_base_url
    "#{request.protocol}#{request.host}#{request.port == 80 ? '' : ':' + request.port.to_s}#{request.path_info}"
  end

  def neat_pages_base_params
    request.env['action_dispatch.request.query_parameters']
  end

  def neat_pages_navigation(options={})
    NeatPages::Helpers::Navigation.new(pagination, neat_pages_base_url, neat_pages_base_params).generate(options)
  end

  def neat_pages_status
    NeatPages::Helpers::Status.new(pagination, neat_pages_base_url, neat_pages_base_params).generate
  end

  ::ActionView::Base.send :include, self
end

require 'neat_pages/helpers/builder'
require 'neat_pages/helpers/navigation'
require 'neat_pages/helpers/status'
