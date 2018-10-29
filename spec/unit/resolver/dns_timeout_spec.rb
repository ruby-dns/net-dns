require 'spec_helper'
require 'net/dns/resolver/timeouts'

describe Net::DNS::Resolver::DnsTimeout do
  subject { described_class.new(10) }

  describe "#initialize" do
    it "returns an instance of DnsTimeout" do
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
    it "returns the seconds" do
      expect(subject.to_s).to eq("10")
    end
  end

  describe "#timeout" do
    it "requires a block" do
      expect { subject.timeout }.to raise_error(LocalJumpError)
    end
  end
end
