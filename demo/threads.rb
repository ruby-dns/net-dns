require 'rubygems' if RUBY_VERSION.to_s < "1.9.0"
require 'net/dns'

a = ["ibm.com", "sun.com", "redhat.com"]

threads = []

a.each do |dom|
  threads << Thread.new(dom) do |domain|
    res = Net::DNS::Resolver.new
    res.query(domain, Net::DNS::NS).each_nameserver do |ns|
      puts "Domain #{domain} has nameserver #{ns}"
    end
    puts ""
  end
end

threads.each(&:join)
