require 'test/unit'
require 'net/dns/question'

class Test_Question < Test::Unit::TestCase
  include Net::DNS

  def setup
    @domain = 'example.com.'
    @type   = 'MX'
    @cls  = 'HS'
    @data = "\006google\003com\000\000\001\000\001"
    
    @default = Question.new(@domain)
    @string  = Question.new(@domain,@type,@cls)
    @binary  = Question.parse(@data)
    @binary2 = Question.parse(@string.data)
  end
  
  def test_simple
    assert_equal(@default.qName, @domain)
    assert_equal(@default.qType.to_s, "A")
    assert_equal(@default.qClass.to_s, "IN")

    assert_equal(@string.qName, @domain)
    assert_equal(@string.qType.to_s, "MX")
    assert_equal(@string.qClass.to_s, "HS")
    
    assert_equal(@binary.qName, "google.com.")
    assert_equal(@binary.qType.to_s, "A")
    assert_equal(@binary.qClass.to_s, "IN")
    
    assert_equal(@binary2.qName, @domain)
    assert_equal(@binary2.qType.to_s, "MX")
    assert_equal(@binary2.qClass.to_s, "HS")
   end

  def test_raise
    assert_raise(QuestionNameError) do
      Question.new(1)
    end
    assert_raise(QuestionNameError) do
      Question.new("test{")
    end
    assert_raise(QuestionArgumentError) do
      Question.parse(Array.new)
    end
    assert_raise(QuestionArgumentError) do
      Question.parse("test")
    end
    
  end
  
  
end    
