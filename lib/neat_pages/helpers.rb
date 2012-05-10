# encoding : utf-8
module NeatPages
  #*************************************************************************************
  # TOCOMMENT
  #*************************************************************************************
  class Helpers
    #*************************************************************************************
    # CONSTRUCTOR
    #*************************************************************************************
    def initialize(pagination, base_url, params)
      @pagination = pagination
      @base_url = base_url
      @params = params
    end


    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def navigation
      if paginated?
        content = ''
        content << navigation_link('previous') if previous?
        content << navigation_link('next') if next?

        return "<div class=\"pagination\">#{content.html_safe}</div>".html_safe
      else
        return ''
      end
    end

    def status
      return '' if empty? or out_of_bound?

      from = offset
      to = from + per_page
      to = total_items if to > total_items

      return "#{from+1} #{t('to')} #{to}/#{total_items}"
    end

    private

    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    def navigation_link(direction)
      label_str = direction == 'next' ? "#{t('page_next')} »" : "« #{t('page_previous')}"

      link_url = path_to(send("#{direction}_page"))

      return "<a href=\"#{link_url}\" class=\"#{direction}\">#{label_str}</a>".html_safe
    end

    def path_to(page)
      qs = ["page=#{page}"]

      @params.each { |k,v| qs << "#{k}=#{v}" if k != 'page' }

      return @base_url + '?' + qs.join("&")
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
end
