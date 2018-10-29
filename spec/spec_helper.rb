require 'rspec'
require 'net/dns'

unless defined?(SPEC_ROOT)
  SPEC_ROOT = File.expand_path(__dir__)
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(SPEC_ROOT, "support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
end
