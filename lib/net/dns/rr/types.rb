module Net # :nodoc:
  module DNS
    class RR
      # This is an auxiliary class to handle RR type field in a DNS packet.
      class Types
        TYPES = {
          'SIGZERO' => 0,     # RFC2931 consider this a pseudo type
          'A' => 1,           # RFC 1035, Section 3.4.1
          'NS' => 2,          # RFC 1035, Section 3.3.11
          'MD' => 3,          # RFC 1035, Section 3.3.4 (obsolete)
          'MF' => 4,          # RFC 1035, Section 3.3.5 (obsolete)
          'CNAME' => 5,       # RFC 1035, Section 3.3.1
          'SOA' => 6,         # RFC 1035, Section 3.3.13
          'MB' => 7,          # RFC 1035, Section 3.3.3 (obsolete)
          'MG' => 8,          # RFC 1035, Section 3.3.6 (obsolete)
          'MR' => 9,          # RFC 1035, Section 3.3.8 (obsolete)
          'NULL' => 10,       # RFC 1035, Section 3.3.10 (obsolete)
          'WKS' => 11,        # RFC 1035, Section 3.4.2 (obsolete)
          'PTR' => 12,        # RFC 1035, Section 3.3.12
          'HINFO' => 13,      # RFC 1035, Section 3.3.2
          'MINFO' => 14,      # RFC 1035, Section 3.3.7 (obsolete)
          'MX' => 15,         # RFC 1035, Section 3.3.9
          'TXT' => 16,        # RFC 1035, Section 3.3.14
          'RP' => 17,         # RFC 1183, Section 2.2 (obsolete)
          'AFSDB' => 18,      # RFC 1183, Section 1
          'X25' => 19,        # RFC 1183, Section 3.1 (obsolete)
          'ISDN' => 20,       # RFC 1183, Section 3.2 (obsolete)
          'RT' => 21,         # RFC 1183, Section 3.3 (obsolete)
          'NSAP' => 22,       # RFC 1706, Section 5 (obsolete)
          'NSAP_PTR' => 23,   # RFC 1348 (obsolete) (obsolete)
          'SIG' => 24,        # RFC 2535, Section 4.1 (obsolete)
          'KEY' => 25,        # RFC 2535, Section 3.1 (obsolete)
          'PX' => 26,         # RFC 2163, (obsolete)
          'GPOS' => 27,       # RFC 1712 (obsolete)
          'AAAA' => 28,       # RFC 1886, Section 2.1
          'LOC' => 29,        # RFC 1876
          'NXT' => 30,        # RFC 2535, Section 5.2 (obsolete)
          'EID' => 31,        # draft-ietf-nimrod-dns-xx.txt (obsolete)
          'NIMLOC' => 32,     # draft-ietf-nimrod-dns-xx.txt (obsolete)
          'SRV' => 33,        # RFC 2052
          'ATMA' => 34,       # ??? (obsolete)
          'NAPTR' => 35,      # RFC 2168
          'KX' => 36,         # RFC 2230
          'CERT' => 37,       # RFC 2538
          'DNAME' => 39,      # RFC 2672
          'OPT' => 41,        # RFC 2671
          'APL' => 42,        # RFC 3123 (obsolete)
          'DS' => 43,         # RFC 4034
          'SSHFP' => 44,      # RFC 4255
          'IPSECKEY' => 45,   # RFC 4025
          'RRSIG' => 46,      # RFC 4034
          'NSEC' => 47,       # RFC 4034
          'DNSKEY' => 48,     # RFC 4034
          'DHCID' => 49,      # RFC 4701
          'NSEC3' => 50,      # RFC 5155
          'NSEC3PARAM' => 51, # RFC 5155
          'TLSA' => 52,       # RFC 6698
          'SMIMEA' => 53,     # RFC 8162
          'HIP' => 55,        # RFC 8005
          'CDS' => 59,        # RFC 7344
          'CDNSKEY' => 60,    # RFC 7344
          'OPENPGPKEY' => 61, # RFC 7929
          'CSYNC' => 62,      # RFC 7477
          'ZONEMD' => 63,     # RFC 8976
          'SVCB' => 64,       # RFC 9460
          'HTTPS' => 65,      # RFC 9460
          'SPF' => 99,        # RFC 4408 (obsolete)
          'UINFO' => 100,     # non-standard (obsolete)
          'UID' => 101,       # non-standard (obsolete)
          'GID' => 102,       # non-standard (obsolete)
          'UNSPEC' => 103,    # non-standard (obsolete)
          'EUI48' => 108,     # RFC 7043
          'EUI64' => 109,     # RFC 7043
          'TKEY' => 249,      # RFC 2930
          'TSIG' => 250,      # RFC 2931
          'IXFR' => 251,      # RFC 1995
          'AXFR' => 252,      # RFC 1035
          'MAILB' => 253,     # RFC 1035 (MB, MG, MR) (obsolete)
          'MAILA' => 254,     # RFC 1035 (obsolete - see MX)
          'ANY' => 255,       # RFC 1035
          'URI' => 256,       # RFC 7553
          'CAA' => 257,       # RFC 6844
        }.freeze

        # The default value when type is nil in Resource Records
        @@default = TYPES["A"]

        def self.default
          @@default
        end

        # Be able to control the default type to assign when
        # type is +nil+. Default to +A+
        def self.default=(str)
          raise ArgumentError, "Unknown type #{str}" unless TYPES.key? str

          @@default = TYPES[str]
        end

        # Checks whether +type+ is a valid RR type.
        def self.valid?(type)
          case type
          when String
            TYPES.key?(type)
          when Integer
            TYPES.invert.key?(type)
          else
            raise ArgumentError, "Wrong type class: #{type.class}"
          end
        end

        # Returns the type in string format, as "A" or "NS",
        # given the numeric value
        def self.to_str(type)
          case type
          when Integer
            raise ArgumentError, "Unknown type number #{type}" unless TYPES.invert.key? type

            TYPES.invert[type]

          else
            raise ArgumentError, "Wrong type class: #{type.class}"
          end
        end

        # Gives in output the keys from the +Types+ hash
        # in a format suited for regexps
        def self.regexp
          # Longest ones go first, so the regex engine will match AAAA before A.
          TYPES.keys.sort { |a, b| b.length <=> a.length }.join("|")
        end

        # Creates a new object representing an RR type. Performs some
        # checks on the argument validity too. Il +type+ is +nil+, the
        # default value is +ANY+ or the one set with Types.default=
        def initialize(type)
          case type
          when String
            # type in the form "A" or "NS"
            new_from_string(type.upcase)
          when Integer
            # type in numeric form
            new_from_num(type)
          when nil
            # default type, control with Types.default=
            @str = TYPES.invert[@@default]
            @num = @@default
          else
            raise ArgumentError, "Wrong type class: #{type.class}"
          end
        end

        # Returns the type in number format
        # (default for normal use)
        def inspect
          @num
        end

        # Returns the type in string format,
        # i.d. "A" or "NS" or such a string.
        def to_s
          @str
        end

        # Returns the type in numeric format,
        # usable by the pack methods for data transfers
        def to_i
          @num.to_i
        end

        def to_str
          @num.to_s
        end

        private

        # Constructor for string data type.
        def new_from_string(type)
          case type
          when /^TYPE\\d+/
            # TODO!!!
          else
            # String with name of type
            raise ArgumentError, "Unknown type #{type}" unless TYPES.key? type

            @str = type
            @num = TYPES[type]

          end
        end

        # Contructor for numeric data type.
        def new_from_num(type)
          raise ArgumentError, "Unkown type number #{type}" unless TYPES.invert.key? type

          @num = type
          @str = TYPES.invert[type]
        end
      end
    end
  end
end
