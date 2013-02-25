# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "neat-pages"
  s.version     = "0.1.1"
  s.authors     = ["Sebastien Rosa"]
  s.email       = ["sebastien@demarque.com"]
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.licenses    = ["MIT"]
  s.homepage    = "https://github.com/demarque/neat-pages"
  s.summary     = "A simple pagination API to paginate Mongoid Models."
  s.description = "A simple pagination API to paginate Mongoid Models."

  s.rubyforge_project = "neat-pages"

  s.files         = Dir.glob('{app,config,lib,spec,vendor}/**/*') + %w(LICENSE README.md Rakefile Gemfile)
  s.require_paths = ["lib"]

  s.add_development_dependency('rake', ['>= 0.8.7'])
  s.add_development_dependency('rspec', ['>= 2.0'])
  s.add_development_dependency('rails', ['>= 3.0'])
end
