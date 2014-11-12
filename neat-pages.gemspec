Gem::Specification.new do |gem|
  gem.name        = "neat-pages"
  gem.description = "A simple pagination API to paginate ActiveRecord and Mongoid Models."
  gem.summary     = "A simple pagination API to paginate ActiveRecord and Mongoid Models."
  gem.homepage    = "https://github.com/alchimikweb/neat-pages"
  gem.version     = "1.0.4"
  gem.licenses    = ["MIT"]

  gem.authors     = ["Sebastien Rosa"]
  gem.email       = ["srosa@alchimik.com"]

  gem.files       = `git ls-files`.split($\)
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files  = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails", ['>= 4.0']
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "rspec-its"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "simplecov-rcov-text"
  #gem.add_development_dependency "coveralls"
end
