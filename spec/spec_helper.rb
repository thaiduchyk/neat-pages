ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'
require 'simplecov-rcov-text'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::RcovTextFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter "spec/dummy"
  add_filter "spec/support"
  add_filter "spec/neat-pages_spec.rb"
end

require File.expand_path("../dummy/config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'

Dir["./spec/support/**/*.rb"].sort.each {|f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
end
