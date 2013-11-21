#*************************************************************************************
# Builder will help build a string of html output.
#*************************************************************************************
class NeatPages::Helpers::Builder
  attr_reader :pagination

  delegate :per_page,     to: :pagination
  delegate :total_items,  to: :pagination

  def initialize(pagination, request)
    @pagination = pagination
    @base_url = generate_base_url_from_request(request)
    @params = request.env['action_dispatch.request.query_parameters']
    @params.delete('utf8')

    reset_builder
  end

  def b(str='')
    @builder << str

    @builder.html_safe
  end

  def li(content, css_class='', options={})
    options = { hidden: false }.merge(options)

    attributes = ' class="' + css_class + '"' if not css_class.empty?
    attributes << ' style="display:none"' if options[:hidden]

    b "<li#{attributes}>#{content}</li>"
  end

  def path_to(page)
    "#{@base_url}?" +
    @params.map { |k,v| "#{k}=#{v}" if k != 'page' }.compact.join('&') +
    (@params.empty? ? '' : '&') +
    "page=#{page}"
  end

  def reset_builder
    @builder = ''
  end

  def t(text_path)
    (defined? I18n) ? I18n.t("neat_pages.#{text_path}") : text_path
  end

  private

  def generate_base_url_from_request(request)
    "#{request.protocol}#{request.host}#{request.port == 80 ? '' : ':' + request.port.to_s}#{request.path_info}"
  end
end
