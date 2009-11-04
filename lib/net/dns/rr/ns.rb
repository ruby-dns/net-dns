module Net
  module DNS
    
    class RR
      
      #------------------------------------------------------------
      # RR type NS
      #------------------------------------------------------------
      class NS < RR
        attr_reader :nsdname

        private
        
        def check_name(name)
          unless name =~ /(\w\.?)+\s*$/ and name =~ /[a-zA-Z]/
            raise ArgumentError, "NS Domain Name not valid: #{name}"
          end
          name
        end

        def build_pack
          @nsdname_pack = pack_name(@nsdname)
          @rdlength = @nsdname_pack.size
        end

        def get_data
          @nsdname_pack
        end

        def get_inspect
          "#@nsdname"
        end
          
        def subclass_new_from_hash(args)
          if args.has_key? :nsdname
            @nsdname = check_name args[:nsdname]
          else
            raise ArgumentError, ":nsdname field is mandatory but missing"
          end
        end

        def subclass_new_from_string(str)
          @nsdname = check_name(str)
        end

        def subclass_new_from_binary(data,offset)
          @nsdname,offset = dn_expand(data,offset)
          return offset
        end
        
        private
        
          def set_type
            @type = Net::DNS::RR::Types.new("NS")
          end
        
      end # class NS
      
    end # class RR
  end # module DNS
end # module Net



