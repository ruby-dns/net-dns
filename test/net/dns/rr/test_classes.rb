require 'test/unit'
require 'net/dns/rr/classes'

class Test_Classes < Test::Unit::TestCase
  def setup
    @classes = {
      'IN'        => 1,       # RFC 1035
      'CH'        => 3,       # RFC 1035
      'HS'        => 4,       # RFC 1035
      'NONE'      => 254,     # RFC 2136
      'ANY'       => 255,     # RFC 1035
    }
    @regexp_string = "HS|ANY|NONE|CH|IN"
  end
    
  def test_default
    # Default type should be ANY => 255
    instance = Net::DNS::RR::Classes.new(nil)
    assert_equal("1", instance.to_str)
    assert_equal("IN", instance.to_s)
    
    # Let's change default behaviour
    Net::DNS::RR::Classes.default = "CH"
    instance = Net::DNS::RR::Classes.new(nil)
    assert_equal("3", instance.to_str)
    assert_equal("CH", instance.to_s)

    Net::DNS::RR::Classes.default = "IN"
    instance = Net::DNS::RR::Classes.new(nil)
    assert_equal("1", instance.to_str)
    assert_equal("IN", instance.to_s)
    
  end

  def test_classes
    @classes.each do |key,num|
      instance_from_string = Net::DNS::RR::Classes.new(key) 
      instance_from_num = Net::DNS::RR::Classes.new(num)
      assert_equal(key, instance_from_string.to_s)
      assert_equal(num.to_s, instance_from_string.to_str)
      assert_equal(key, instance_from_num.to_s)
      assert_equal(num.to_s, instance_from_num.to_str)
    end
    assert_raise(ClassArgumentError) do
      Net::DNS::RR::Classes.new(Hash.new)
    end
  end

  def test_regexp
    assert_equal(@regexp_string, Net::DNS::RR::Classes.regexp)
  end
  
  def test_valid
    assert_equal(true,  Net::DNS::RR::Classes.valid?("IN"))
    assert_equal(true,  Net::DNS::RR::Classes.valid?(1))
    assert_equal(false, Net::DNS::RR::Classes.valid?("Q"))
    assert_equal(false, Net::DNS::RR::Classes.valid?(256))
    assert_raise(ClassArgumentError) do
      Net::DNS::RR::Classes.valid? Hash.new
    end
  end

  def test_to_str
    assert_equal("IN", Net::DNS::RR::Classes.to_str(1))
    assert_raise(ClassArgumentError) do
      Net::DNS::RR::Classes.to_str(256)
    end
    assert_raise(ClassArgumentError) do
      Net::DNS::RR::Classes.to_str("string")
    end
  end

end
