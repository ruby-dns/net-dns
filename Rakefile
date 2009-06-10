require 'rubygems'
require 'rake'

#
# Gem specifications
#
SPEC = Gem::Specification.new do |s|
  s.name      = "net-dns"
  s.authors   = ["Marco Ceresa"]
  s.email     = "ceresa@gmail.com"
  s.homepage  = "http://github.com/bluemonk/net-dns"
  s.platform  = Gem::Platform::RUBY
  s.summary   = "Pure Ruby DNS library"
  s.has_rdoc         = true
  s.extra_rdoc_files = ["README.rdoc","AUTHORS","INSTALL", "THANKS"]
  s.description = "Net::DNS is a pure Ruby DNS library, with a clean OO interface and an extensible API"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new(SPEC)
rescue LoadError
  puts "Jeweler not available."
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    puts "Not found!"
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "net-dns #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Upload project on RubyForge"
task :upload do
  rubyforge = Rake::RubyForgePublisher.new("net-dns","bluemonk")
  rubyforge.upload
end


def egrep(pattern)
  Dir['**/*.rb'].each do |fn|
    count = 0
    open(fn) do |f|
      while line = f.gets
        count += 1
        if line =~ pattern
          puts "#{fn}:#{count}:#{line}"
        end
      end
    end
  end
end

desc "Look for TODO and FIXME tags in the code"
task :todo do
  egrep /(FIXME|TODO|TBD)/
end





