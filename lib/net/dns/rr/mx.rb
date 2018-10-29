module Net # :nodoc:
  module DNS
    class RR
      #
      # = Mail Exchange Record (MX)
      #
      # Class for DNS MX resource records.
      #
      # A MX record specifies the name and relative preference of mail servers
      # (mail exchangers in the DNS jargon) for the zone.
      # The MX RR is used by SMTP (Mail) Agents to route mail for the domain.
      #
      class MX < RR
        # Gets the preference value.
        #
        # Returns an Integer.
        attr_reader :preference

        # Gets the exchange value.
        #
        # Returns a String.
        attr_reader :exchange

        # Gets the standardized value for this record,
        # represented by the value of <tt>preference</tt> and <tt>exchange</tt>.
        #
        # Returns a String.
        def value
          "#{preference} #{exchange}"
        end

        private

        def subclass_new_from_hash(options)
          if options.key?(:preference) && options.key?(:exchange)
            @preference = options[:preference].to_i
            @exchange = options[:exchange]
          else
            raise ArgumentError, ":preference and :exchange fields are mandatory"
          end
        end

        def subclass_new_from_string(str)
          @preference, @exchange = check_mx(str)
        end

        def subclass_new_from_binary(data, offset)
          @preference = data.unpack("@#{offset} n")[0]
          offset += 2
          @exchange, offset = dn_expand(data, offset)
          offset
        end

        def set_type
          @type = Net::DNS::RR::Types.new("MX")
        end

        def get_inspect
          value
        end

        def check_mx(input)
          str = input.to_s
          unless str.strip =~ /^(\d+)\s+(\S+)$/
            raise ArgumentError, "Invalid MX section `#{str}'"
          end

          [Regexp.last_match(1).to_i, Regexp.last_match(2)]
        end

        def build_pack
          @mx_pack = [@preference].pack("n") + pack_name(@exchange)
          @rdlength = @mx_pack.size
        end

        def get_data
          @mx_pack
        end
      end
    end
  end
end
