require 'test_helper'
require 'net/dns/rr'

class RRNSTest < Test::Unit::TestCase
  
  def setup
    @rr_name    = "google.com."
    @rr_type    = "NS"
    @rr_cls     = "IN"
    @rr_ttl     = 10800
    @rr_nsdname = "ns1.google.com."
    
    @rr_output  = "google.com.             10800   IN      NS      ns1.google.com."
  end
  
  
  def test_initialize_from_hash
    @record = Net::DNS::RR::NS.new(:name => @rr_name, :nsdname => @rr_nsdname)
    assert_equal @rr_output,  @record.inspect
    assert_equal @rr_name,    @record.name
    assert_equal @rr_type,    @record.type
    assert_equal @rr_cls,     @record.cls
    assert_equal @rr_ttl,     @record.ttl
    assert_equal @rr_nsdname, @record.nsdname
  end
  
  def test_initialize_from_string
    @record = Net::DNS::RR::NS.new("#{@rr_name} 10800 IN NS #{@rr_nsdname}")
    assert_equal @rr_output,  @record.inspect
    assert_equal @rr_name,    @record.name
    assert_equal @rr_type,    @record.type
    assert_equal @rr_cls,     @record.cls
    assert_equal @rr_ttl,     @record.ttl
    assert_equal @rr_nsdname, @record.nsdname
  end
  
  def test_parse
    data = "\006google\003com\000\000\002\000\001\000\000*0\000\020\003ns1\006google\003com\000"
    @record = Net::DNS::RR.parse(data)
    assert_equal @rr_output,  @record.inspect
    assert_equal @rr_name,    @record.name
    assert_equal @rr_type,    @record.type
    assert_equal @rr_cls,     @record.cls
    assert_equal @rr_ttl,     @record.ttl
    assert_equal @rr_nsdname, @record.nsdname
  end
  
  
  InvalidArguments = [
    { :name => "google.com", :address => "255.256" },
    { :name => "google.com" },
    Object.new,
    Array.new(7),
    "10800 IN A",
  ]
  
  InvalidArguments.each_with_index do |arguments, index|
    define_method "test_initialize_should_raise_with_invalid_arguments_#{index}" do
      assert_raise(Net::DNS::RR::ArgumentError) { Net::DNS::RR::A.new(arguments) }
    end
  end

end
    
