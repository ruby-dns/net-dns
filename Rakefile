require 'rake/clean'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/contrib/rubyforgepublisher' 
require 'rake/gempackagetask' 

require 'rubygems'

$VERSION = "0.4"

task :package => [:version, :clean]

desc "Library version"
task :version do
  file = "lib/net/dns/dns.rb"
  str = IO.readlines(file).to_s
  offset = (str =~ /VERSION = "(.*)"/)
  unless $1 == $VERSION
    str.gsub!($1,$VERSION)
    File.open(file,"w") do |out|
      out << str
    end
  end
end


desc "Run the tests"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/net/dns/**/test*.rb']
  t.verbose = true
end

desc "Install the library"
task :install do
  sh("sudo ruby setup.rb")
end

desc "Build documentation"
Rake::RDocTask.new do |rd|
  rd.rdoc_files.include("lib/net/dns/**/*.rb")
  rd.options << "-S"
end

#
# Gem specifications
#
SPEC = Gem::Specification.new do |s|
  s.name      = "net-dns"
  s.version   = "#$VERSION"
  s.author    = "Marco Ceresa"
  s.email     = "ceresa@gmail.com"
  s.homepage  = "http://net-dns.rubyforge.org/"
  s.platform  = Gem::Platform::RUBY
  s.summary   = "Pure Ruby DNS library"
  candidates  = Dir.glob("**/*")
  s.files     = candidates.delete_if do |item|
                  item.include?("CVS") || item.include?("rdoc") || item.include?("pkg") || item.include?(".svn")
                end
  s.has_rdoc         = true
  s.extra_rdoc_files = ["README","AUTHORS","INSTALL", "THANKS"]
  s.description = <<EOF
A pure Ruby DNS library, similar to the Perl Net::DNS library
EOF
end

# 
# Build packages
#
desc "Build packages"
Rake::GemPackageTask.new(SPEC) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end

# 
# RubyForge publisher
#
desc "Upload project on RubyForge"
task :upload do
  rubyforge = Rake::RubyForgePublisher.new("net-dns","bluemonk")
  rubyforge.upload
end
