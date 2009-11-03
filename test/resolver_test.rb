require 'test_helper'
require 'net/dns/resolver'

class Net::DNS::Resolver
  attr_reader :config
end


class ResolverTest < Test::Unit::TestCase
  
  def test_initialize
    assert_nothing_raised { Net::DNS::Resolver.new } 
  end
  
  def test_initialize_with_config
    assert_nothing_raised { Net::DNS::Resolver.new({}) } 
  end
  
  def test_initialize_with_invalid_config_should_raise_argumenterror
    assert_raise(Net::DNS::Resolver::ArgumentError) { Net::DNS::Resolver.new("") } 
    assert_raise(Net::DNS::Resolver::ArgumentError) { Net::DNS::Resolver.new(0) } 
    assert_raise(Net::DNS::Resolver::ArgumentError) { Net::DNS::Resolver.new(:foo) } 
  end
  
  
  RubyPlatforms = [
    ["darwin9.0", false],   # Mac OS X
    ["darwin", false],      # JRuby on Mac OS X
    ["linux-gnu", false],
    ["mingw32", true],      # ruby 1.8.6 (2008-03-03 patchlevel 114) [i386-mingw32]
    ["mswin32", true],      # ruby 1.8.6 (2008-03-03 patchlevel 114) [i386-mswin32]
    ["mswin32", true],      # ruby 1.8.6 (2008-04-22 rev 6555) [x86-jruby1.1.1]
  ]
  
  def test_self_platform_windows_question
    RubyPlatforms.each do |platform, is_windows|
      assert_equal is_windows, 
                    override_platform(platform) { Net::DNS::Resolver.platform_windows? }, 
                    "Expected `#{is_windows}' with platform `#{platform}'"
    end
  end
  
  
  protected
  
    def override_platform(new_platform, &block)
      raise LocalJumpError, "no block given" unless block_given?
      old_platform = Config::CONFIG["host_os"]
      Config::CONFIG["host_os"] = new_platform
      result = yield
    ensure
      Config::CONFIG["host_os"] = old_platform
      result
    end
  
end