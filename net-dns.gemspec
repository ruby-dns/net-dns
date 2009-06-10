# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{net-dns}
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marco Ceresa"]
  s.date = %q{2009-06-10}
  s.description = %q{Net::DNS is a pure Ruby DNS library, with a clean OO interface and an extensible API}
  s.email = %q{ceresa@gmail.com}
  s.extra_rdoc_files = [
    "AUTHORS",
     "INSTALL",
     "README.rdoc",
     "THANKS"
  ]
  s.files = [
    "AUTHORS",
     "CHANGELOG",
     "INSTALL",
     "README.rdoc",
     "Rakefile",
     "THANKS",
     "VERSION.yml",
     "demo/check_soa.rb",
     "demo/threads.rb",
     "lib/net/dns/dns.rb",
     "lib/net/dns/header.rb",
     "lib/net/dns/names/names.rb",
     "lib/net/dns/packet.rb",
     "lib/net/dns/question.rb",
     "lib/net/dns/resolver.rb",
     "lib/net/dns/resolver/socks.rb",
     "lib/net/dns/resolver/timeouts.rb",
     "lib/net/dns/rr.rb",
     "lib/net/dns/rr/a.rb",
     "lib/net/dns/rr/aaaa.rb",
     "lib/net/dns/rr/classes.rb",
     "lib/net/dns/rr/cname.rb",
     "lib/net/dns/rr/hinfo.rb",
     "lib/net/dns/rr/mr.rb",
     "lib/net/dns/rr/mx.rb",
     "lib/net/dns/rr/ns.rb",
     "lib/net/dns/rr/null.rb",
     "lib/net/dns/rr/ptr.rb",
     "lib/net/dns/rr/soa.rb",
     "lib/net/dns/rr/srv.rb",
     "lib/net/dns/rr/txt.rb",
     "lib/net/dns/rr/types.rb",
     "setup.rb",
     "test/net/dns/resolver/test_timeouts.rb",
     "test/net/dns/rr/test_a.rb",
     "test/net/dns/rr/test_classes.rb",
     "test/net/dns/rr/test_ns.rb",
     "test/net/dns/rr/test_types.rb",
     "test/net/dns/test_header.rb",
     "test/net/dns/test_packet.rb",
     "test/net/dns/test_question.rb",
     "test/net/dns/test_rr.rb"
  ]
  s.homepage = %q{http://github.com/bluemonk/net-dns}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Pure Ruby DNS library}
  s.test_files = [
    "test/net/dns/test_header.rb",
     "test/net/dns/rr/test_types.rb",
     "test/net/dns/rr/test_a.rb",
     "test/net/dns/rr/test_ns.rb",
     "test/net/dns/rr/test_classes.rb",
     "test/net/dns/resolver/test_timeouts.rb",
     "test/net/dns/test_rr.rb",
     "test/net/dns/test_packet.rb",
     "test/net/dns/test_question.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
