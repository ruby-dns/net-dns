require 'rubygems'
require 'rake'
require 'rake/clean'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name              = "net-dns"
    gemspec.summary           = "Pure Ruby DNS library"
    gemspec.description       = "Net::DNS is a pure Ruby DNS library, with a clean OO interface and an extensible API"
    gemspec.authors           = ["Marco Ceresa", "Simone Carletti"]
    gemspec.email             = ["ceresa@gmail.com", "weppos@weppos.net"]
    gemspec.homepage          = "http://github.com/bluemonk/net-dns"
    gemspec.extra_rdoc_files  = ["README.rdoc", "CHANGELOG.rdoc", "AUTHORS.rdoc", "THANKS.rdoc"]
    gemspec.rubyforge_project = "net-dns"
    
    gemspec.add_development_dependency "rcov"
  end
  Jeweler::RubyforgeTasks.new do |rubyforge|
    # prevent Jeweler to inject library name twice
    rubyforge.remote_doc_path = "/"
  end
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

desc "Look for TODO and FIXME tags in the code"
task :todo do
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
  egrep /(FIXME|TODO|TBD)/
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r net/dns.rb"
end
