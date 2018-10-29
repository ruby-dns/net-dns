require 'spec_helper'
require 'net/dns/resolver/timeouts'

describe Net::DNS::Resolver::UdpTimeout do
  subject { described_class.new(10) }

  it "inherits from DnsTimeout" do
    expect(described_class.ancestors).to include(Net::DNS::Resolver::DnsTimeout)
  end

  describe "#initialize" do
    it "returns an instance of TcpTimeout" do
      expect(subject.class).to be(described_class)
    end

    it "sets timeout" do
      expect(described_class.new(0).seconds).to eq(0)
      expect(described_class.new(10).seconds).to eq(10)
    end

    it "raises ArgumentError when timeout is invalid" do
      expect { described_class.new(nil)   }.to raise_error(ArgumentError)
      expect { described_class.new("")    }.to raise_error(ArgumentError)
      expect { described_class.new("foo") }.to raise_error(ArgumentError)
      expect { described_class.new(-1)    }.to raise_error(ArgumentError)
    end
  end

  describe "#to_s" do
    it "returns infinite when seconds is 0" do
      expect(described_class.new(0).to_s).to eq("not defined")
    end

    it "returns the seconds" do
      expect(subject.to_s).to eq("10")
    end
  end

  describe "#pretty_to_s" do
    it "returns a more verbose version" do
      expect(described_class.new(30).pretty_to_s).to eq("30 seconds")
      expect(described_class.new(90).pretty_to_s).to eq("1 minutes and 30 seconds")
      expect(described_class.new(3690).pretty_to_s).to eq("1 hours, 1 minutes and 30 seconds")
    end
  end
end
