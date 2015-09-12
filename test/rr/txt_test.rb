require 'test_helper'
require 'net/dns/rr'

class RRTXTTest < Test::Unit::TestCase

  def setup
    @rr_name    = "example.com."
    @rr_type    = "TXT"
    @rr_cls     = "IN"
    @rr_ttl     = 10800
    @rr_txt = "This is an example TXT record."
    
    @rr_output  = "example.com.            10800   IN      TXT     \"This is an example TXT record.\""

    @rr         = Net::DNS::RR::TXT.new(:name => "example.com.", :txt => "This is an example TXT record.", :ttl => @rr_ttl)
  end


  def test_initialize_from_hash
    @record = Net::DNS::RR::TXT.new(:name => "example.com.", :txt => "This is an example TXT record.")
    assert_equal @rr_output,  @record.inspect
    assert_equal @rr_name,    @record.name
    assert_equal @rr_type,    @record.type
    assert_equal @rr_cls,     @record.cls
    assert_equal @rr_ttl,     @record.ttl
    assert_equal @rr_txt, @record.txt
  end

  def test_initialize_from_string
    @record = Net::DNS::RR::TXT.new("example.com. 10800 IN TXT \"This is an example TXT record.\"")
    assert_equal @rr_output,  @record.inspect
    assert_equal @rr_name,    @record.name
    assert_equal @rr_type,    @record.type
    assert_equal @rr_cls,     @record.cls
    assert_equal @rr_ttl,     @record.ttl
    assert_equal @rr_txt, @record.txt
  end

  def test_parse
    data = "\007example\003com\000\000\020\000\001\000\000*0\000\037\036This is an example TXT record."
    @record = Net::DNS::RR.parse(data)
    assert_equal @rr_output,  @record.inspect
    assert_equal @rr_name,    @record.name
    assert_equal @rr_type,    @record.type
    assert_equal @rr_cls,     @record.cls
    assert_equal @rr_ttl,     @record.ttl
    assert_equal @rr_txt, @record.txt
  end


  InvalidArguments = [
    { :name => "example.com" },
    Object.new,
    Array.new(7),
    "10800 IN A",
  ]
  
  InvalidArguments.each_with_index do |arguments, index|
    define_method "test_initialize_should_raise_with_invalid_arguments_#{index}" do
      assert_raises(ArgumentError) { Net::DNS::RR::TXT.new(arguments) }
    end
  end


  def test_value
    assert_equal  "\"This is an example TXT record.\"", @rr.value
  end


  def test_inspect
    assert_equal  "example.com.            10800   IN      TXT     \"This is an example TXT record.\"",
                  @rr.inspect
  end

  def test_to_s
    assert_equal  "example.com.            10800   IN      TXT     \"This is an example TXT record.\"",
                  @rr.to_s
  end

  def test_to_a
    assert_equal  ["example.com.", 10800, "IN", "TXT", "\"This is an example TXT record.\""],
                  @rr.to_a
  end

end
