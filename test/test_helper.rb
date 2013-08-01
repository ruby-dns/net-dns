$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'test/unit'
require 'net/dns'

EXPECTED_EXCEPTION_CLASSES = if defined? IPAddr::InvalidAddressError
  [ArgumentError, IPAddr::InvalidAddressError]
else
  [ArgumentError]
end
