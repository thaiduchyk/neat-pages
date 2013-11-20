module NeatPages
  #*************************************************************************************
  # TOCOMMENT
  #*************************************************************************************
  class Base
    attr_accessor :per_page
    attr_reader :current_page
    attr_reader :total_items

    #*************************************************************************************
    # CONSTRUCTOR
    #*************************************************************************************
    def initialize(current_page_param, options={})
      options = { per_page: 10, total_items: 0 }.merge(options)

      @per_page = options[:per_page].to_i
      @total_items = options[:total_items]

      init_current_page current_page_param

      @out_of_bound = init_out_of_bound
    end


    #*************************************************************************************
    # PUBLIC INSTANCE METHODS
    #*************************************************************************************
    def empty?
      @total_items == 0
    end

    def limit
      @per_page
    end

    def next_page
      next? ? (@current_page + 1) : total_pages
    end

    def next?
      @current_page < total_pages and not out_of_bound?
    end

    def offset
      if out_of_bound?
        total_items + 1
      else
        (@current_page - 1) * @per_page
      end
    end

    def out_of_bound?
      @out_of_bound
    end

    def paginated?
      @total_items > @per_page
    end

    def previous_page
      previous? ? (@current_page - 1) : 1
    end

    def previous?
      @current_page > 1 and not out_of_bound?
    end

    def response_headers
      {
        "X-Total-Items" => @total_items.to_s,
        "X-Total-Pages" => total_pages.to_s,
        "X-Per-Page" => @per_page.to_s,
        "X-Current-Page" => @current_page.to_s
      }
    end

    def set_total_items(qte)
      @total_items = qte
      @out_of_bound = init_out_of_bound
    end

    def total_pages
      total = (@total_items.to_f / @per_page).ceil
      total != 0 ? total : 1
    end

    private

    #*************************************************************************************
    # PRIVATE INSTANCE METHODS
    #*************************************************************************************
    def init_current_page(current_page_param)
      @current_page = current_page_param.to_i
      @current_page = 1 if @current_page == 0
    end

    def init_out_of_bound
      @current_page <= 0 or @current_page > total_pages
    end
  end
end
