# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "readable/version"

Gem::Specification.new do |s|
  s.name        = "readable"
  s.version     = Readable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Zhang Yuanyi"]
  s.email       = ["zhangyuanyi@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Readable make web content easier to read}
  s.description = %q{Readable provides a more confortable way to read web.}

  s.add_development_dependency "rspec"
  s.add_dependency 'nokogiri'
  s.add_dependency 'sanitize'
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
