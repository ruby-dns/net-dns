require 'rubygems'
SPEC = Gem::Specification.new do |s|
  s.name      = "net-dns"
  s.version   = "0.5-rc"
  s.author    = "Marco Ceresa"
  s.email     = "ceresa@gmail.com"
  s.homepage  = "http://github.com/bluemonk/net-dns/"
  s.platform  = Gem::Platform::RUBY
  s.summary   = "Pure Ruby DNS library"
  candidates  = Dir.glob("{bin,demo,docs,lib,tests}/**/*")
  s.files     = candidates.delete_if do |item|
                  item.include?("CVS") || item.include?("rdoc") || item.include?(".svn")
                end
  s.has_rdoc         = true
  s.extra_rdoc_files = ["README.rdoc","AUTHORS","INSTALL", "THANKS"]
end