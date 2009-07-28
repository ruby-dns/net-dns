require 'test_helper'
require 'net/dns/rr'

class RRTypesTest < Test::Unit::TestCase

  def setup
    @types = {
      'SIGZERO'   => 0, 
      'A'         => 1, 
      'NS'        => 2, 
      'MD'        => 3, 
      'MF'        => 4, 
      'CNAME'     => 5, 
      'SOA'       => 6, 
      'MB'        => 7, 
      'MG'        => 8, 
      'MR'        => 9, 
      'NULL'      => 10,
      'WKS'       => 11,
      'PTR'       => 12,
      'HINFO'     => 13,
      'MINFO'     => 14,
      'MX'        => 15,
      'TXT'       => 16,
      'RP'        => 17,
      'AFSDB'     => 18,
      'X25'       => 19,
      'ISDN'      => 20,
      'RT'        => 21,
      'NSAP'      => 22,
      'NSAP_PTR'  => 23,
      'SIG'       => 24,
      'KEY'       => 25,
      'PX'        => 26,
      'GPOS'      => 27,
      'AAAA'      => 28,
      'LOC'       => 29,
      'NXT'       => 30,
      'EID'       => 31,
      'NIMLOC'    => 32,
      'SRV'       => 33,
      'ATMA'      => 34,
      'NAPTR'     => 35,
      'KX'        => 36,
      'CERT'      => 37,
      'DNAME'     => 39,
      'OPT'       => 41,
      'DS'        => 43,
      'SSHFP'     => 44,
      'RRSIG'     => 46,
      'NSEC'      => 47,
      'DNSKEY'    => 48, 
      'UINFO'     => 100,
      'UID'       => 101,
      'GID'       => 102,
      'UNSPEC'    => 103,
      'TKEY'      => 249,
      'TSIG'      => 250,
      'IXFR'      => 251,
      'AXFR'      => 252,
      'MAILB'     => 253,
      'MAILA'     => 254,
      'ANY'       => 255,
    }

    @regexp_string = "A|AAAA|AFSDB|ANY|ATMA|AXFR|CERT|CNAME|DNAME|DNSKEY|DS|EID|GID|GPOS|HINFO|ISDN|IXFR|KEY|KX|LOC|MAILA|MAILB|MB|MD|MF|MG|MINFO|MR|MX|NAPTR|NIMLOC|NS|NSAP|NSAP_PTR|NSEC|NULL|NXT|OPT|PTR|PX|RP|RRSIG|RT|SIG|SIGZERO|SOA|SRV|SSHFP|TKEY|TSIG|TXT|UID|UINFO|UNSPEC|WKS|X25"
  end
    
  def test_default
    # Default type should be ANY => 255
    instance = Net::DNS::RR::Types.new(nil)
    assert_equal("1", instance.to_str)
    assert_equal("A", instance.to_s)
    
    # Let's change default behaviour
    Net::DNS::RR::Types.default = "A"
    instance = Net::DNS::RR::Types.new(nil)
    assert_equal("1", instance.to_str)
    assert_equal("A", instance.to_s)

    Net::DNS::RR::Types.default = "ANY"
    instance = Net::DNS::RR::Types.new(nil)
    assert_equal("255", instance.to_str)
    assert_equal("ANY", instance.to_s)
  end

  def test_types
    @types.each do |key,num|
      instance_from_string = Net::DNS::RR::Types.new(key) 
      instance_from_num = Net::DNS::RR::Types.new(num)
      assert_equal(key, instance_from_string.to_s)
      assert_equal(num.to_s, instance_from_string.to_str)
      assert_equal(key, instance_from_num.to_s)
      assert_equal(num.to_s, instance_from_num.to_str)
    end
    assert_raise(TypeArgumentError) do
      Net::DNS::RR::Types.new(Hash.new)
    end
  end

  def test_regexp
    assert_equal(@regexp_string, Net::DNS::RR::Types.regexp)
  end
  
  def test_valid
    assert_equal(true,  Net::DNS::RR::Types.valid?("A"))
    assert_equal(true,  Net::DNS::RR::Types.valid?(1))
    assert_equal(false, Net::DNS::RR::Types.valid?("Q"))
    assert_equal(false, Net::DNS::RR::Types.valid?(256))
    assert_raise(TypeArgumentError) do
      Net::DNS::RR::Types.valid? Hash.new
    end
  end

  def test_to_str
    assert_equal("A", Net::DNS::RR::Types.to_str(1))
    assert_raise(TypeArgumentError) do
      Net::DNS::RR::Types.to_str(256)
    end
    assert_raise(TypeArgumentError) do
      Net::DNS::RR::Types.to_str("string")
    end
  end

end
