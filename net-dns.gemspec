require_relative "lib/net/dns/version"

Gem::Specification.new do |s|
  s.name        = "net-dns"
  s.version     = Net::DNS::VERSION
  s.authors     = ["Marco Ceresa", "Simone Carletti"]
  s.email       = ["ceresa@gmail.com", "weppos@weppos.net"]

  s.summary     = "Pure Ruby DNS library."
  s.description = "Net::DNS is a pure Ruby DNS library, with a clean OO interface and an extensible API."
  s.homepage    = "http://github.com/bluemonk/net-dns"
  s.licenses    = ["Ruby"]
  s.required_ruby_version = ">= 2.6"

  s.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
          f.start_with?(*%w[bin/ spec/ test/ .git .rubocop Gemfile Rakefile])
    end
  end
  s.require_paths = ["lib"]
  s.extra_rdoc_files = %w(LICENSE.txt)
end
