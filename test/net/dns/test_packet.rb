require 'test/unit'
require 'net/dns/packet'

class Test_Packet < Test::Unit::TestCase
  include Net::DNS

  def setup
    @domain = 'example.com'
    @type   = 'MX'
    @cls  = 'HS'
     
    @default = Packet.new(@domain)
    @string = Packet.new(@domain, MX, HS)
    
    packet = "\337M\201\200\000\001\000\003\000\004\000\004\006google\003com\000\000\001\000\001\300\f\000\001\000\001\000\000\001,\000\004@\351\273c\300\f\000\001\000\001\000\000\001,\000\004H\016\317c\300\f\000\001\000\001\000\000\001,\000\004@\351\247c\300\f\000\002\000\001\000\003\364\200\000\006\003ns1\300\f\300\f\000\002\000\001\000\003\364\200\000\006\003ns2\300\f\300\f\000\002\000\001\000\003\364\200\000\006\003ns3\300\f\300\f\000\002\000\001\000\003\364\200\000\006\003ns4\300\f\300X\000\001\000\001\000\003\307\273\000\004\330\357 \n\300j\000\001\000\001\000\003\307\273\000\004\330\357\"\n\300|\000\001\000\001\000\003\307\273\000\004\330\357$\n\300\216\000\001\000\001\000\003\307\273\000\004\330\357&\n"
    
    @binary = Packet.parse(packet)
    
  end
  
  def test_instances
    assert_instance_of(Net::DNS::Packet, @string)
    assert_instance_of(Net::DNS::Header, @string.header)
    assert_instance_of(Array, @string.question)
    assert_instance_of(Net::DNS::Question, @string.question[0])
    assert_instance_of(Array, @string.answer)
    assert_instance_of(Array, @string.authority)
    assert_instance_of(Array, @string.additional)    

    assert_instance_of(Net::DNS::Packet, @binary)    
    assert_instance_of(Net::DNS::Header, @binary.header)
    assert_instance_of(Array, @binary.question)
    assert_instance_of(Net::DNS::Question, @binary.question[0])
    assert_instance_of(Array, @binary.answer)
    assert_instance_of(Net::DNS::RR::A, @binary.answer[0])
    assert_instance_of(Array, @binary.authority)
    assert_instance_of(Net::DNS::RR::NS, @binary.authority[0])
    assert_instance_of(Array, @binary.additional)    
    assert_instance_of(Net::DNS::RR::A, @binary.additional[0])    
  end
  
end    
