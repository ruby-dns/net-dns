require 'rubygems'
require 'rubygems/package_task'
require 'bundler'
require 'rake/testtask'
require 'yard'
require 'yard/rake/yardoc_task'

$:.unshift(File.dirname(__FILE__) + '/lib')
require 'net/dns'


# Common package properties
PKG_NAME    = ENV['PKG_NAME']    || 'net-dns'
PKG_VERSION = ENV['PKG_VERSION'] || Net::DNS::VERSION

if ENV['SNAPSHOT'].to_i == 1
  PKG_VERSION << "." << Time.now.utc.strftime("%Y%m%d%H%M%S")
end


# Run test by default.
task :default => :test

# This builds the actual gem. For details of what all these options
# mean, and other ones you can add, check the documentation here:
#
#   http://rubygems.org/read/chapter/20
#
spec = Gem::Specification.new do |s|
  s.name              = PKG_NAME
  s.version           = PKG_VERSION
  s.summary           = "Pure Ruby DNS library."
  s.description       = "Net::DNS is a pure Ruby DNS library, with a clean OO interface and an extensible API."

  s.authors           = ["Marco Ceresa", "Simone Carletti"]
  s.email             = ["ceresa@gmail.com", "weppos@weppos.net"]
  s.homepage          = "http://github.com/bluemonk/net-dns"
  s.rubyforge_project = "net-dns"

  s.files             = %w( Rakefile ) +
                        Dir.glob("*.{rdoc,gemspec}") +
                        Dir.glob("{demo,lib,test}/**/*")
  s.require_paths     = ["lib"]

  # If you want to depend on other gems, add them here, along with any
  # relevant versions
  # s.add_dependency("some_other_gem", "~> 0.1.0")
end

# This task actually builds the gem.
# We also regenerate a static .gemspec file.
Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end


# Run all the tests in the /test folder
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

YARD::Rake::YardocTask.new(:yardoc) do |y|
  y.options = ["--output-dir", "yardoc"]
end


desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r net/dns.rb"
end
