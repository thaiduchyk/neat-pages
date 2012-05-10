module NeatPages
  module Implants
  end
end

if defined? Rails::Railtie
  require 'neat_pages/implants/railtie'
elsif defined? Rails::Initializer
  raise "neat-pages is not compatible with Rails 2.3 or older"
end

require 'neat_pages/implants/mongoid_implant'
