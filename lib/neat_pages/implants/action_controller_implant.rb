module NeatPages::Implants::ActionControllerImplant
  extend ActiveSupport::Concern

  included do
    append_after_filter :set_pagination_header
    helper_method :pagination, :pagination_helpers
    rescue_from NeatPages::OutOfBound, :with => :render_out_of_bound
  end

  def paginate(options={})
    options.reverse_merge!(:per_page => 20)

    base_current_url = request.protocol + request.host + request.path_info

    neat_pages = NeatPages::Base.new(params[:page], options)
    neat_pages.activate_helpers(base_current_url, request.env['rack.request.query_hash'])

    @_env['neat_pages'] = neat_pages
  end

  def pagination
    @_env['neat_pages']
  end

  def pagination_helpers
    pagination.helpers
  end

  def render_out_of_bound
    render :text => "out_of_bound", :status => 404
  end

  def set_pagination_header
    response.headers.merge! pagination.response_headers if pagination
  end
end
