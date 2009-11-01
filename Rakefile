require 'rubygems'
require 'rake'

#
# Gem specifications
#
SPEC = Gem::Specification.new do |s|
  s.name              = "net-dns"
  s.summary           = "Pure Ruby DNS library"
  s.description       = "Net::DNS is a pure Ruby DNS library, with a clean OO interface and an extensible API"
  s.authors           = ["Marco Ceresa"]
  s.email             = "ceresa@gmail.com"
  s.homepage          = "http://github.com/bluemonk/net-dns"
  s.extra_rdoc_files  = ["README.rdoc", "CHANGELOG.rdoc", "AUTHORS.rdoc", "THANKS.rdoc"]
  s.rubyforge_project = "net-dns"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new(SPEC)
  Jeweler::RubyforgeTasks.new
rescue LoadError
  puts "Jeweler not available."
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new(:rcov) do |test|
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

begin
  require 'rake/contrib/sshpublisher'
  namespace :rubyforge do
    
    desc "Release gem and RDoc documentation to RubyForge"
    task :release => ["rubyforge:release:gem", "rubyforge:release:docs"]
    
    namespace :release do
      desc "Publish RDoc to RubyForge."
      task :docs => [:rdoc] do
        config = YAML.load(
            File.read(File.expand_path('~/.rubyforge/user-config.yml'))
        )
 
        host = "#{config['username']}@rubyforge.org"
        remote_dir = "/var/www/gforge-projects/net-dns"
        local_dir = 'rdoc'
 
        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
      end
    end
  end
rescue LoadError
  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
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





