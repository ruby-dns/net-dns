require 'test/unit'
require 'net/dns/rr'

class Test_A < Test::Unit::TestCase
  def setup
    
    @name = "google.com."
    @type = "A"
    @cls = "IN"
    @ttl = 10800
    @address = "64.233.187.99"

    
    @hash = Net::DNS::RR::A.new(:name => @name,
                                :address => @address)
    
    @string = Net::DNS::RR::A.new("google.com. 10800 IN A 64.233.187.99")
    
    @arr = Net::DNS::RR.parse(@string.data)

    @str = "google.com.             10800   IN      A       64.233.187.99"
  end
    
  def test_simple
    assert_equal(@str,@hash.inspect)
    assert_equal(@name, @hash.name)
    assert_equal(@type, @hash.type)
    assert_equal(@cls, @hash.cls)
    assert_equal(@ttl, @hash.ttl)
    assert_equal(@address, @hash.address.to_s)

    assert_equal(@str, @string.inspect)
    assert_equal(@name, @string.name)
    assert_equal(@type, @string.type)
    assert_equal(@cls, @string.cls)
    assert_equal(@ttl, @string.ttl)
    assert_equal(@address, @string.address.to_s)
    
    assert_equal(@str, @arr.inspect)
    assert_equal(@name, @arr.name)
    assert_equal(@type, @arr.type)
    assert_equal(@cls, @arr.cls)
    assert_equal(@ttl, @arr.ttl)
    assert_equal(@address, @arr.address.to_s)
  end

  def test_range
    assert_raise(RRArgumentError) do 
      Net::DNS::RR::A.new(:name => "google.com",
                          :address => "255.256")
    end
    assert_raise(RRArgumentError) do
      Net::DNS::RR::A.new(:name => "google.com")
    end
    assert_raise(RRArgumentError) do
      Net::DNS::RR::A.new(Object.new)
    end
    assert_raise(RRArgumentError) do
      Net::DNS::RR::A.new(Array.new(7))
    end
    assert_raise(RRArgumentError) do
      Net::DNS::RR::A.new("10800 IN A")
    end
    assert_raise(RRArgumentError) do
      Net::DNS::RR::A.new("google.com. 10800 IN B")
    end
    assert_raise(RRArgumentError) do
      Net::DNS::RR::A.new("google.com. 10800 IM A")
    end
  end
end
    
