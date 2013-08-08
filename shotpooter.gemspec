# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "shotpooter/version"

Gem::Specification.new do |s|
  s.name        = "shotpooter"
  s.version     = MyGem::VERSION
  s.authors     = ["Ben Lopatin"]
  s.email       = ["ben.lopatin@wellfireinteractive.com"]
  s.homepage    = "http://www.github.com/bennylope/shotpooter"
  s.description  = %q{A tool for generating BrowserStack screenshots from the command line.}
  s.summary     = s.description
  s.licenses = ['MIT']

  s.rubyforge_project = "shotpooter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "thor"
  s.add_runtime_dependency "browserstack-screenshot"
end
