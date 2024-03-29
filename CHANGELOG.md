# Changelog


## Release 0.20.0

- CHANGED: Minimum Ruby version is now 2.7

- CHANGED: Merged changes from gitlab-net-dns @stanhu

- FIXED: Fixed undefined method 'size' errors (GH-46, GH-81) @stanhu

- FIXED: uninitialized constant Net::DNS::Resolver::TimeoutError (GH-82, GH-83, GH-84)

- ADDED: Added URI/SPF/CAA type code


## Release 0.9.0

- CHANGED: Major code cleanup.

- CHANGED: Minimum Ruby version is now 2.1

- FIXED: Fixed CI run (GH-77).

- FIXED: Fixed deprecated references to Fixnum.


## Release 0.8.0

- FIXED: undefined local variable or method `source_address_inet6' (GH-40). @simsicon

- FIXED: Fixed bug on parsing multiple nameservers on different lines (GH-45). @nicholasren
  
- CHANGED: Dropped duplicate query ID filter. Query ID is now randomically generated but it's not guaranteed to be unique (GH-39). @ebroder

- CHANGED: require 'net/dns' is now the preferred way to load the library (GH-37). @johnroa

- CHANGED: Removed setup.rb installation script.


## Release 0.7.1

- FIXED: Invalid file permissions on several files (GH-35) @jamespharaoh


## Release 0.7.0

- ADDED: Added (experimental) Support for HINFO record.

- FIXED: Use Net::DNS::Resolver::Error class (not ResolverError, which does not exist).

- FIXED: Cleaned up require dependency and recursive require statements.

- FIXED: Use RbConfig instead of obsolete and deprecated Config (GH-28, GH-33) @shadowbq, @eik3

- FIXED: SRV record not required by Net::DNS::RR (GH-27) @sebastian

- FIXED: Resolver now supports IPv6 (GH-32) @jamesotron

- FIXED: Net::DNS::RR::PTR references an invalid parameter (GH-19) @dd23

- FIXED: Net::DNS::Question changes input arguments (GH-7) @gfarfl

- CHANGED: Refactoring unit test to follow most used Ruby conventions.

- CHANGED: Rewritten and simplified Net::DNS::Classes. Improved test harness.

- CHANGED: Removed Jeweler development dependency.

- CHANGED: The library is now compatible with Bundler.

- CHANGED: Minimum supported Ruby version changed to Ruby 1.8.7.

- CHANGED: Rescue NameError so unsupported record types only result in a warning.

- CHANGED: Renamed Net::DNS::Resolver#send to Net::DNS::Resolver#query to avoid overriding default meaning of send method.


## Release 0.6.1

- ADDED: Net::DNS::Packet#to_s method (alias of #inspect)

- FIXED: typo in lib/net/dns/rr/ptr.rb. Thanks Chris Lundquist.

- FIXED: warning: method redefined; discarding old inspect (GH-3). Thanks Kevin Baker.

- FIXED: issue with rescue ArgumentError (GH-5) and with IPAddr handling (GH-6)


## Release 0.6.0

*WARNING:- If you are upgrading from a previous minor release, check out the Compatibility issue list below.

- FIXED: Added missing #to_s method to Net::DNS::Question.

- FIXED: Compatibility with Ruby 1.9

- FIXED: Types regexp order issue

- CHANGED: Refactoring unit test to follow most used Ruby conventions

- CHANGED: default timeout is now 5 seconds for both UDP and TCP

- CHANGED: Moved main dns.rb file to lib/net folder as default for GEMs. In this way it can be autoloaded when the gem is required.

### Compatibility issues

- CHANGED: RR#set_stype scope is now private to prevent invalid usage.

- CHANGED: DnsTimeout#timeout now raises LocalJumpError instead of DnsTimeoutArgumentError when block is missing.

- CHANGED: Renamed Net::DNS::RR::Types::Types to Net::DNS::RR::Types::TYPES to follow Ruby coding standards.


## Release 0.4

- many bug fixes (thanks guys!)
- a whole new class Net::DNS::Header::RCode
- new methods in Net::DNS::Resolver class to do AXFR queries
- a new SRV resource record written by Dan Janowski
- more documentation written and corrected
