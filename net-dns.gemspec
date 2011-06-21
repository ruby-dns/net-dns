# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{net-dns}
  s.version = "0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Marco Ceresa}, %q{Simone Carletti}]
  s.date = %q{2011-06-21}
  s.description = %q{Net::DNS is a pure Ruby DNS library, with a clean OO interface and an extensible API.}
  s.email = [%q{ceresa@gmail.com}, %q{weppos@weppos.net}]
  s.files = [%q{Rakefile}, %q{AUTHORS.rdoc}, %q{CHANGELOG.rdoc}, %q{README.rdoc}, %q{THANKS.rdoc}, %q{net-dns.gemspec}, %q{demo/check_soa.rb}, %q{demo/threads.rb}, %q{lib/net}, %q{lib/net/dns}, %q{lib/net/dns/core_ext.rb}, %q{lib/net/dns/header.rb}, %q{lib/net/dns/names.rb}, %q{lib/net/dns/packet.rb}, %q{lib/net/dns/question.rb}, %q{lib/net/dns/resolver}, %q{lib/net/dns/resolver/socks.rb}, %q{lib/net/dns/resolver/timeouts.rb}, %q{lib/net/dns/resolver.rb}, %q{lib/net/dns/rr}, %q{lib/net/dns/rr/a.rb}, %q{lib/net/dns/rr/aaaa.rb}, %q{lib/net/dns/rr/classes.rb}, %q{lib/net/dns/rr/cname.rb}, %q{lib/net/dns/rr/hinfo.rb}, %q{lib/net/dns/rr/mr.rb}, %q{lib/net/dns/rr/mx.rb}, %q{lib/net/dns/rr/ns.rb}, %q{lib/net/dns/rr/null.rb}, %q{lib/net/dns/rr/ptr.rb}, %q{lib/net/dns/rr/soa.rb}, %q{lib/net/dns/rr/srv.rb}, %q{lib/net/dns/rr/txt.rb}, %q{lib/net/dns/rr/types.rb}, %q{lib/net/dns/rr.rb}, %q{lib/net/dns/version.rb}, %q{lib/net/dns.rb}, %q{test/header_test.rb}, %q{test/packet_test.rb}, %q{test/question_test.rb}, %q{test/resolver}, %q{test/resolver/timeouts_test.rb}, %q{test/resolver_test.rb}, %q{test/rr}, %q{test/rr/a_test.rb}, %q{test/rr/aaaa_test.rb}, %q{test/rr/classes_test.rb}, %q{test/rr/cname_test.rb}, %q{test/rr/hinfo_test.rb}, %q{test/rr/mr_test.rb}, %q{test/rr/mx_test.rb}, %q{test/rr/ns_test.rb}, %q{test/rr/types_test.rb}, %q{test/rr_test.rb}, %q{test/test_helper.rb}]
  s.homepage = %q{http://github.com/bluemonk/net-dns}
  s.require_paths = [%q{lib}]
  s.rubyforge_project = %q{net-dns}
  s.rubygems_version = %q{1.8.3}
  s.summary = %q{Pure Ruby DNS library.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
