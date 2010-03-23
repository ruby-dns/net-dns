require 'ipaddr'

module Net # :nodoc:
  module DNS
    class RR

      #
      # = IPv4 Address Record (A)
      #
      # Class for DNS IPv4 Address (A) resource records.
      #
      # The resource data is an IPv4 (i.e. 32 bit long) address,
      # hold in the instance variable +address+.
      #
      #   a = Net::DNS::RR::A.new("localhost.movie.edu. 360 IN A 127.0.0.1")
      #
      #   a = Net::DNS::RR::A.new(:name    => "localhost.movie.edu.",
      #                           :ttl     => 360,
      #                           :cls     => Net::DNS::IN,
      #                           :type    => Net::DNS::A,
      #                           :address => "127.0.0.1" )
      #
      # When computing binary data to transmit the RR, the RDATA section is an
      # Internet address expressed as four decimal numbers separated by dots
      # without any embedded space (e.g. "10.2.0.52" or "192.0.5.6").
      #
      class A < RR

        # Returns the <tt>IPAddr</tt> IPv4 address for this record.
        def address
          @address
        end

        # Assigns a new IPv4 address to this record, which can be in the
        # form of a <tt>String</tt> or an <tt>IPAddr</tt> object.
        #
        #   a.address = "192.168.0.1"
        #   a.address = IPAddr.new("10.0.0.1")
        #
        def address=(string_or_ipaddr)
          @address = check_address(string_or_ipaddr)
          build_pack
          @address
        end

        # Returns the standardized value for this record as <tt>String</tt>,
        # represented by the value of <tt>address</tt>.
        def value
          address.to_s
        end


        private

          def subclass_new_from_hash(options)
            if options.has_key? :address
              @address = check_address(options[:address])
            elsif options.has_key? :rdata
              @address = check_address(options[:rdata])
            else
              raise ArgumentError, ":address field is mandatory"
            end
          end

          def subclass_new_from_string(str)
            @address = check_address(str)
          end

          def subclass_new_from_binary(data, offset)
            a, b, c, d = data.unpack("@#{offset} CCCC")
            @address = IPAddr.new("#{a}.#{b}.#{c}.#{d}")
            offset + 4
          end


          def set_type
            @type = Net::DNS::RR::Types.new("A")
          end

          def get_inspect
            value
          end


          def check_address(addr)
            address = case addr
              when IPAddr
                addr
              when Integer # Address in numeric form
                tmp = [(addr >> 24), (addr >> 16) & 0xFF, (addr >> 8) & 0xFF, addr & 0xFF]
                tmp = tmp.collect { |x| x.to_s }.join(".")
                IPAddr.new(tmp)
              when String
                IPAddr.new(addr)
              else
                raise ArgumentError, "Unknown address `#{addr}'"
            end

            if !address.ipv4?
              raise(ArgumentError, "Must specify an IPv4 address")
            end

            address
          end

          def build_pack
            @address_pack = @address.hton
            @rdlength = @address_pack.size
          end

          def get_data
            @address_pack
          end

      end

    end
  end
end
