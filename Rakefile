require 'rubygems'
require 'rake'
require 'rake/clean'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name              = "net-dns"
    gemspec.summary           = "Pure Ruby DNS library"
    gemspec.description       = "Net::DNS is a pure Ruby DNS library, with a clean OO interface and an extensible API"
    gemspec.authors           = ["Marco Ceresa"]
    gemspec.email             = "ceresa@gmail.com"
    gemspec.homepage          = "http://github.com/bluemonk/net-dns"
    gemspec.extra_rdoc_files  = ["README.rdoc", "CHANGELOG.rdoc", "AUTHORS.rdoc", "THANKS.rdoc"]
    gemspec.rubyforge_project = "net-dns"
    
    gemspec.add_development_dependency "rcov"
  end
  Jeweler::RubyforgeTasks.new
rescue LoadError
  puts "Jeweler not available."
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs   << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new(:rcov) do |test|
    test.libs   << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov => :check_dependencies
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config  = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    puts "VERSION.yml not found!"
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "net-dns #{version}"
  rdoc.rdoc_files.include('*.rdoc')
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
