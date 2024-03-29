module Net # :nodoc:
  module DNS
    class RR
      #
      # = Canonical Name Record (CNAME)
      #
      # Class for DNS CNAME resource records.
      #
      # A CNAME record maps an alias or nickname to the real or Canonical name
      # which may lie outside the current zone.
      # Canonical means expected or real name.
      #
      class CNAME < RR
        # Gets the canonical name value.
        #
        # Returns a String.
        attr_reader :cname

        # Gets the standardized value for this record,
        # represented by the value of <tt>cname</tt>.
        #
        # Returns a String.
        def value
          cname.to_s
        end

        private

        def subclass_new_from_hash(options)
          raise ArgumentError, ":cname field is mandatory" unless options.key?(:cname)

          @cname = check_name(options[:cname])
        end

        def subclass_new_from_string(str)
          @cname = check_name(str)
        end

        def subclass_new_from_binary(data, offset)
          @cname, offset = dn_expand(data, offset)
          offset
        end

        def set_type
          @type = Net::DNS::RR::Types.new("CNAME")
        end

        def get_inspect
          value
        end

        def check_name(input)
          name = input.to_s
          unless name =~ /(\w\.?)+\s*$/ && name =~ /[a-zA-Z]/
            raise ArgumentError, "Invalid Canonical Name `#{name}'"
          end

          name
        end

        def build_pack
          @cname_pack = pack_name(@cname)
          @rdlength = @cname_pack.size
        end

        def get_data
          @cname_pack
        end
      end
    end
  end
end
