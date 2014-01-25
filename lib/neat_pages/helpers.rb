#*************************************************************************************
# Insert a bunch of helper methods in the ActionView::Base of a Rails project.
#*************************************************************************************
module NeatPages::Helpers
  def neat_pages_ajax_items(partial_path, options={})
    options = { wrapper: :div }.merge(options)

    ("<#{options[:wrapper]} id=\"neat-pages-ajax-wrapper\" class=\"first-load\">" + render(partial_path, options) + "</#{options[:wrapper]}>").html_safe
  end

  # DEPRECATED : The options parameter is deprecated. I left it here for backward compatibility. (2013-11-20)
  def neat_pages_navigation(options={})
    NeatPages::Helpers::Navigation.new(pagination, request).generate
  end

  def neat_pages_link_relation_tags
    NeatPages::Helpers::Relation.new(pagination, request).generate
  end

  def neat_pages_status
    NeatPages::Helpers::Status.new(pagination, request).generate
  end

  ::ActionView::Base.send :include, self
end

require 'neat_pages/helpers/builder'
require 'neat_pages/helpers/navigation'
require 'neat_pages/helpers/relation'
require 'neat_pages/helpers/status'
