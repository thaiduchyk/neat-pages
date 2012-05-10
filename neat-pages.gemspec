# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "neat-pages"
  s.version     = "0.0.1"
  s.authors     = ["Sebastien Rosa"]
  s.email       = ["sebastien@demarque.com"]
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.licenses    = ["MIT"]
  s.homepage    = "https://github.com/demarque/neat-pages"
  s.summary     = ""
  s.description = ""

  s.rubyforge_project = "neat-pages"

  s.files         = Dir.glob('{lib,spec}/**/*') + %w(LICENSE README.md Rakefile Gemfile)
  s.require_paths = ["lib"]

  s.add_development_dependency('rake', ['>= 0.8.7'])
  s.add_development_dependency('rspec', ['>= 2.0'])
end
