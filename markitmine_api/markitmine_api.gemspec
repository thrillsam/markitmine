$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "markitmine_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "markitmine_api"
  s.version     = MarkitmineApi::VERSION
  s.authors     = ["thrikal"]
  s.email       = ["thrikal.vakilsearch@gmail.com"]
  s.homepage    = "http://libra.vakilserach.com"
  s.summary     = "Markitmine"
  s.description = "Markitmine"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.6"

  s.add_development_dependency "sqlite3"
end
