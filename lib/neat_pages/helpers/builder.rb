#*************************************************************************************
# Builder will help build a string of html output.
#*************************************************************************************
class NeatPages::Helpers::Builder
  def initialize(pagination, base_url, params)
    @pagination = pagination
    @base_url = base_url
    @params = params
    @params.delete('utf8')
    reset_builder
  end

  def b(str='')
    @builder << str

    return @builder.html_safe
  end

  def li(content, css_class='', hidden=false)
    attributes = 'class="' + css_class + '" '
    attributes << 'style="display:none"' if hidden

    return "<li #{attributes}>#{content}</li>"
  end

  def path_to(page)
    return @base_url + '?' + @params.map { |k,v| "#{k}=#{v}"}.join('&') + "&page=#{page}"
  end

  def reset_builder
    @builder = ''
  end

  def t(text_path)
    (defined? I18n) ? I18n.t("neat_pages.#{text_path}") : text_path
  end

  def method_missing(*args, &block)
    if @pagination.respond_to? args.first
      return @pagination.send *args, &block
    else
      raise NoMethodError.new("undefined local variable or method '#{args.first}' for #{self.class}")
    end
  end

end
