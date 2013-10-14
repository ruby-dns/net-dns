module Net # :nodoc:
  module DNS
    class RR

      #------------------------------------------------------------
      # RR type SPF
      #------------------------------------------------------------
      class SPF < TXT

        def spf
          txt
        end

        private

          def set_type
            @type = Net::DNS::RR::Types.new("SPF")
          end

      end

    end
  end
end
