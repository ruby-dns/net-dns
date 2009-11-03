# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{net-dns}
  s.version = "0.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marco Ceresa"]
  s.date = %q{2009-11-02}
  s.description = %q{Net::DNS is a pure Ruby DNS library, with a clean OO interface and an extensible API}
  s.email = %q{ceresa@gmail.com}
  s.extra_rdoc_files = [
    "AUTHORS.rdoc",
     "CHANGELOG.rdoc",
     "README.rdoc",
     "THANKS.rdoc"
  ]
  s.files = [
    ".gitignore",
     "AUTHORS.rdoc",
     "CHANGELOG.rdoc",
     "README.rdoc",
     "Rakefile",
     "THANKS.rdoc",
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
     "net-dns.gemspec",
     "setup.rb",
     "test/header_test.rb",
     "test/packet_test.rb",
     "test/question_test.rb",
     "test/resolver/timeouts_test.rb",
     "test/resolver_test.rb",
     "test/rr/a_test.rb",
     "test/rr/classes_test.rb",
     "test/rr/ns_test.rb",
     "test/rr/types_test.rb",
     "test/rr_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/bluemonk/net-dns}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{net-dns}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Pure Ruby DNS library}
  s.test_files = [
    "test/header_test.rb",
     "test/rr_test.rb",
     "test/rr/a_test.rb",
     "test/rr/types_test.rb",
     "test/rr/classes_test.rb",
     "test/rr/ns_test.rb",
     "test/question_test.rb",
     "test/resolver/timeouts_test.rb",
     "test/test_helper.rb",
     "test/resolver_test.rb",
     "test/packet_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end
