require "bundler/gem_tasks"

task default: :test
task test: [:minitest, :spec] # rubocop:disable Style/SymbolArray


require "rake/testtask"

Rake::TestTask.new(:minitest) do |t|
  t.libs = %w[lib test]
  t.pattern = "test/**/*_test.rb"
  t.verbose = !ENV["VERBOSE"].nil?
  t.warning = !ENV["WARNING"].nil?
end


require "rubocop/rake_task"

RuboCop::RakeTask.new


require "rspec/core/rake_task"

RSpec::Core::RakeTask.new do |t|
  t.verbose = !ENV["VERBOSE"].nil?
end


require "yard/rake/yardoc_task"

YARD::Rake::YardocTask.new(:yardoc) do |y|
  y.options = ["--output-dir", "yardoc"]
end

CLOBBER.include "yardoc"
