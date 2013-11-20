#*************************************************************************************
# Insert methods in the Action Controller of a Rails project.
#*************************************************************************************
module NeatPages::Implants::ActionControllerImplant
  extend ActiveSupport::Concern

  included do
    append_after_filter :set_pagination_header

    helper_method :pagination

    rescue_from NeatPages::OutOfBound, with: :render_out_of_bound
  end

  def paginate(options={})
    options.reverse_merge! per_page: 20

    @_env['neat_pages'] = NeatPages::Base.new(params[:page], options)
  end

  def pagination
    @_env['neat_pages']
  end

  def render_out_of_bound
    render text: "out_of_bound", status: 404
  end

  def set_pagination_header
    response.headers.merge! pagination.response_headers if pagination
  end
end
