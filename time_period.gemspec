# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "time_period/version"

Gem::Specification.new do |s|
  s.name        = "time_period"
  s.version     = TimePeriod::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Peter Porn"]
  s.email       = ["ph@metaminded.com"]
  s.homepage    = "https://github.com/metaminded/time_period"
  s.summary     = %q{Store time periods in a single column, with reasonable simple_form support}
  s.description = %q{Store time periods as "1 week" or "2 months" in a single column, with reasonable simple_form support}

  s.rubyforge_project = "time_period"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
