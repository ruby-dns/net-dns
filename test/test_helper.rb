require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new(color: true)

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "net/dns"

module Minitest::Assertions
  def assert_nothing_raised(*)
    yield
  end
end
