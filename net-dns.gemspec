$LOAD_PATH.push File.expand_path('lib', __dir__)
require "net/dns/version"

Gem::Specification.new do |s|
  s.name        = "net-dns"
  s.version     = Net::DNS::VERSION
  s.authors     = ["Marco Ceresa", "Simone Carletti"]
  s.email       = ["ceresa@gmail.com", "weppos@weppos.net"]
  s.homepage    = "http://github.com/bluemonk/net-dns"
  s.summary     = "Pure Ruby DNS library."
  s.description = "Net::DNS is a pure Ruby DNS library, with a clean OO interface and an extensible API."

  s.required_ruby_version = ">= 2.1"

  s.require_paths    = ["lib"]
  s.files            = `git ls-files`.split("\n")
  s.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.extra_rdoc_files = %w[LICENSE.txt]

  s.add_development_dependency "mocha"
  s.add_development_dependency "rake"
  s.add_development_dependency "yard"
end
