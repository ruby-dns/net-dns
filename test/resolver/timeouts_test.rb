require 'test_helper'
require 'net/dns/resolver/timeouts.rb'

class DnsTimeoutTest < Test::Unit::TestCase

  def setup
    @klass = DnsTimeout
  end

  def test_initialize
    timeout = @klass.new(0)
    assert_instance_of @klass, timeout
  end

  def test_initialize_should_set_timeout
    assert_equal 0, @klass.new(0).seconds
    assert_equal 10, @klass.new(10).seconds
  end

  def test_initialize_should_set_raise_with_invalid_timeout
    assert_raise(ArgumentError) { @klass.new(nil) }
    assert_raise(ArgumentError) { @klass.new("") }
    assert_raise(ArgumentError) { @klass.new("foo") }
    assert_raise(ArgumentError) { @klass.new(-1) }
  end


  def test_to_s
    assert_equal "", @klass.new(0).to_s
    assert_equal "1", @klass.new(1).to_s
    assert_equal "10", @klass.new(10).to_s
  end


  def test_timeout_should_raise_localjumperror_without_block
    assert_raise(LocalJumpError) { @klass.new(1).timeout }
  end

end

class TcpTimeoutTest < Test::Unit::TestCase

  def test_initialize
    assert_raise(ArgumentError) do
      TcpTimeout.new("a")
    end
    assert_raise(ArgumentError) do
      TcpTimeout.new(-1)
    end
    assert_raise(TimeoutError) do
      TcpTimeout.new(0.1).timeout { sleep 2 }
    end
  end

  def test_to_s
    assert_equal "infinite", TcpTimeout.new(0).to_s
    assert_equal "30", TcpTimeout.new(30).to_s
  end

  def test_pretty_to_s
    assert_equal "30 seconds", TcpTimeout.new(30).pretty_to_s
    assert_equal "1 minutes and 30 seconds", TcpTimeout.new(90).pretty_to_s
    assert_equal "1 hours, 1 minutes and 30 seconds", TcpTimeout.new(3690).pretty_to_s
  end

  def test_timeout
    assert_equal 2, TcpTimeout.new(1).timeout { 1 + 1 }    
  end

  def test_timeout_should_raise_localjumperror_without_block
    assert_raise(LocalJumpError) { TcpTimeout.new(1).timeout }
  end

end

class UdpTimeoutTest < Test::Unit::TestCase

  def test_initialize
    assert_raise(ArgumentError) do
      UdpTimeout.new("a")
    end
    assert_raise(ArgumentError) do
      UdpTimeout.new(-1)
    end
    assert_raise(TimeoutError) do
      UdpTimeout.new(0.1).timeout {sleep 2}
    end
  end

  def test_to_s
    assert_equal "not defined", UdpTimeout.new(0).to_s
    assert_equal "30", UdpTimeout.new(30).to_s
  end

  def test_pretty_to_s
    assert_equal "30 seconds", UdpTimeout.new(30).pretty_to_s
    assert_equal "1 minutes and 30 seconds", UdpTimeout.new(90).pretty_to_s
    assert_equal "1 hours, 1 minutes and 30 seconds", UdpTimeout.new(3690).pretty_to_s
  end

  def test_timeout
    assert_equal 2, UdpTimeout.new(1).timeout { 1 + 1 }
  end

  def test_timeout_should_raise_localjumperror_without_block
    assert_raise(LocalJumpError) { UdpTimeout.new(1).timeout }
  end

end
