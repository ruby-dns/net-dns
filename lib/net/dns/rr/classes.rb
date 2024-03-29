module Net
  module DNS
    class RR
      #
      # = Net::DNS::Classes
      #
      # This is an auxiliary class to handle <tt>Net::DNS::RR</tt>
      # class field in a DNS packet.
      #
      class Classes
        # Hash with the values of each RR class stored with the
        # respective id number.
        CLASSES = {
          'IN' => 1, # RFC 1035
          'CH' => 3,       # RFC 1035
          'HS' => 4,       # RFC 1035
          'NONE' => 254, # RFC 2136
          'ANY' => 255, # RFC 1035
        }.freeze

        # The default value when class is nil in Resource Records
        @@default = CLASSES["IN"]

        # Creates a new object representing an RR class. Performs some
        # checks on the argument validity too. Il +cls+ is +nil+, the
        # default value is +ANY+ or the one set with Classes.default=
        def initialize(cls)
          case cls
          when String
            initialize_from_str(cls)
          when Integer
            initialize_from_num(cls)
          when nil
            initialize_from_num(@@default)
          end

          return unless @str.nil? || @num.nil?

          raise ArgumentError, "Unable to create a `Classes' from `#{cls}'"
        end

        # Returns the class in number format
        # (default for normal use)
        #
        # FIXME: inspect must return a String.
        #
        def inspect
          @num
        end

        # Returns the class in string format,
        # ex. "IN" or "CH" or such a string.
        def to_s
          @str.to_s
        end

        # Returns the class in numeric format,
        # usable by the pack methods for data transfers.
        def to_i
          @num.to_i
        end

        def self.default
          @@default
        end

        # Be able to control the default class to assign when
        # cls argument is +nil+. Default to +IN+
        def self.default=(str)
          raise ArgumentError, "Unknown class `#{str}'" unless CLASSES[str]

          @@default = CLASSES[str]
        end

        # Returns whether <tt>cls</tt> is a valid RR class.
        #
        #   Net::DNS::RR::Classes.valid?("IN")
        #   # => true
        #   Net::DNS::RR::Classes.valid?(1)
        #   # => true
        #   Net::DNS::RR::Classes.valid?("Q")
        #   # => false
        #   Net::DNS::RR::Classes.valid?(256)
        #   # => false
        #   Net::DNS::RR::Classes.valid?(Hash.new)
        #   # => ArgumentError
        #
        # FIXME: valid? should never raise.
        #
        # ==== Raises
        # ArgumentError:: if <tt>cls</tt> isn't either a String or a Fixnum
        #
        def self.valid?(cls)
          case cls
          when String
            CLASSES.key?(cls)
          when Integer
            CLASSES.invert.key?(cls)
          else
            raise ArgumentError, "Wrong cls class: #{cls.class}"
          end
        end

        # Gives in output the keys from the +Classes+ hash
        # in a format suited for regexps
        def self.regexp
          CLASSES.keys.sort.join("|")
        end

        private

        # Initialize a new instance from a Class name.
        def initialize_from_str(str)
          key = str.to_s.upcase
          @num = CLASSES[key]
          @str = key
        end

        # Initialize a new instance from the Class value.
        def initialize_from_num(num)
          key = num.to_i
          @num = key
          @str = CLASSES.invert[key]
        end
      end
    end
  end
end
