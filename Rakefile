require "bundler/gem_tasks"

# Run test by default.
task default: :test
task test: %i[testunit spec]

require 'rake/testtask'

Rake::TestTask.new(:testunit) do |t|
  t.libs = %w[lib test]
  t.pattern = "test/**/*_test.rb"
  t.verbose = !ENV["VERBOSE"].nil?
  t.warning = !ENV["WARNING"].nil?
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

require 'rspec/core/rake_task'
begin
  require 'fuubar'
rescue LoadError
end

RSpec::Core::RakeTask.new do |t|
  t.verbose = !!ENV["VERBOSE"]
  t.rspec_opts = []
  t.rspec_opts << ['--format', 'Fuubar'] if defined?(Fuubar)
end

require 'yard/rake/yardoc_task'

YARD::Rake::YardocTask.new(:yardoc) do |y|
  y.options = ["--output-dir", "yardoc"]
end

CLOBBER.include "yardoc"
