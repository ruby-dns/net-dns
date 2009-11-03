require 'timeout'

module SecondsHandle #:nodoc: all
  def transform(secs)
    case secs
    when 0
      to_s
    when 1..59
      "#{secs} seconds"
    when 60..3559
      "#{secs/60} minutes and #{secs%60} seconds"
    else
      hours = secs/3600
      secs -= (hours*3600)
      "#{hours} hours, #{secs/60} minutes and #{secs%60} seconds"
    end
  end
end

class DnsTimeout
  include SecondsHandle
  
  def initialize(seconds)
    if seconds.is_a? Numeric and seconds >= 0
      @timeout = seconds
    else
      raise ArgumentError, "Invalid value for tcp timeout"
    end    
  end
  
  def to_s
    if @timeout == 0 
      @output
    else
      @timeout.to_s
    end
  end
  
  def pretty_to_s
    transform(@timeout)
  end
  
  def timeout
    raise LocalJumpError, "no block given" unless block_given?

    if @timeout == 0
      yield
    else
      return Timeout.timeout(@timeout) do
        yield
      end
    end
  end
end

class TcpTimeout < DnsTimeout
  def initialize(seconds)
    @output = "infinite"
    super(seconds)
  end
end

class UdpTimeout < DnsTimeout
  def initialize(seconds)
    @output = "not defined"
    super(seconds)
  end
end