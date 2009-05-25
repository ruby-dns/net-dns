require 'test/unit'
require 'net/dns/rr'

class Test_NS < Test::Unit::TestCase
  def setup
    
    @name = "google.com."
    @type = "NS"
    @cls = "IN"
    @ttl = 10800
    @nsdname = "ns1.google.com."

    
    @hash = Net::DNS::RR::NS.new(:name => @name,
                                 :nsdname => @nsdname)
    
    @string = Net::DNS::RR::NS.new("google.com. 10800 IN NS ns1.google.com.")
    
    @arr = Net::DNS::RR.parse(@string.data)

    @str = "google.com.             10800   IN      NS      ns1.google.com."
  end
    
  def test_simple
    assert_equal(@str,@hash.inspect)
    assert_equal(@name, @hash.name)
    assert_equal(@type, @hash.type)
    assert_equal(@cls, @hash.cls)
    assert_equal(@ttl, @hash.ttl)
    assert_equal(@nsdname, @hash.nsdname)

    assert_equal(@str, @string.inspect)
    assert_equal(@name, @string.name)
    assert_equal(@type, @string.type)
    assert_equal(@cls, @string.cls)
    assert_equal(@ttl, @string.ttl)
    assert_equal(@nsdname, @string.nsdname)
    
    assert_equal(@str, @arr.inspect)
    assert_equal(@name, @arr.name)
    assert_equal(@type, @arr.type)
    assert_equal(@cls, @arr.cls)
    assert_equal(@ttl, @arr.ttl)
    assert_equal(@nsdname, @arr.nsdname)
  end
  
  def test_range
    assert_raise(RRArgumentError) do 
      Net::DNS::RR::NS.new(:name => "google.com",
                          :nsdname => "255.256")
    end
    assert_raise(RRArgumentError) do
      Net::DNS::RR::NS.new(:name => "google.com")
    end
    assert_raise(ArgumentError) do
      Net::DNS::RR::NS.new(Range.new)
    end
    assert_raise(RRArgumentError) do
      Net::DNS::RR::NS.new(Array.new(7))
    end
    assert_raise(RRArgumentError) do
      Net::DNS::RR::NS.new("10800 IN A")
    end
  end
end
    
