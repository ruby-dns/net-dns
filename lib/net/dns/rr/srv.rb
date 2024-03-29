module Net # :nodoc:
  module DNS
    class RR
      #------------------------------------------------------------
      # RR type SRV
      #------------------------------------------------------------
      class SRV < RR
        attr_reader :priority
        attr_reader :weight
        attr_reader :port
        attr_reader :host

        private

        def build_pack
          str = ""
        end

        def subclass_new_from_binary(data, offset)
          off_end = offset + @rdlength
          @priority, @weight, @port = data.unpack("@#{offset} n n n")
          offset += 6

          @host = []
          while offset < off_end
            len = data.unpack1("@#{offset} C")
            offset += 1
            str = data[offset..offset + len - 1]
            offset += len
            @host << str
          end
          @host = @host.join(".")
          offset
        end

        private

        def set_type
          @type = Net::DNS::RR::Types.new("SRV")
        end
      end
    end
  end
end
