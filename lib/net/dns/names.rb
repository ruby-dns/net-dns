module Net # :nodoc:
  module DNS
    module Names
      # Base error class.
      class Error < StandardError
      end

      # Generic Names Error.
      class ExpandError < Error
      end

      INT16SZ = 2

      # Expand a compressed name in a DNS Packet object. Please
      # see RFC1035 for an explanation of how the compression
      # in DNS packets works, how may it be useful and how should
      # be handled.
      #
      # This method accept two parameters: a raw packet data and an
      # offset, which indicates the point in the packet in which the
      # parsing has arrived.
      #
      def dn_expand(packet, offset)
        name = ""
        packetlen = packet.size
        loop do
          raise ExpandError, "Offset is greater than packet length!" if packetlen < (offset + 1)

          len = packet.unpack1("@#{offset} C")

          if len == 0
            offset += 1
            break
          elsif (len & 0xC0) == 0xC0
            raise ExpandError, "Packet ended before offset expand" if packetlen < (offset + INT16SZ)

            ptr = packet.unpack1("@#{offset} n")
            ptr &= 0x3FFF
            name2 = dn_expand(packet, ptr)[0]
            raise ExpandError, "Packet is malformed!" if name2.nil?

            name += name2
            offset += INT16SZ
            break
          else
            offset += 1
            raise ExpandError, "No expansion found" if packetlen < (offset + len)

            elem = packet[offset..offset + len - 1]
            name += "#{elem}."
            offset += len
          end
        end
        [name, offset] # name.chomp(".") if trailing dot has to be omitted
      end

      def pack_name(name)
        if name.size > 255
          raise ArgumentError, "Name may not exceed 255 chars"
        end

        arr = name.split(".")
        str = ""
        arr.each do |elem|
          if elem.size > 63
            raise ArgumentError, "Label may not exceed 63 chars"
          end

          str += [elem.size, elem].pack("Ca*")
        end
        str += [0].pack("C")
        str
      end

      def names_array(name)
        arr = name.split(".")
        ar = []
        string = ""
        arr.size.times do |i|
          x = i + 1
          elem = arr[-x]
          len = elem.size
          string = (string.reverse + [len, elem].pack("Ca*").reverse).reverse
          ar.unshift(string)
        end
        ar
      end

      def dn_comp(name, offset, compnames)
        names = {}
        ptr = 0
        str = ""
        arr = names_array(name)
        arr.each do |entry|
          if compnames.key?(entry)
            ptr = 0xC000 | compnames[entry]
            str += [ptr].pack("n")
            offset += INT16SZ
            break
          else
            len = entry.unpack1("C")
            elem = entry[1..len]
            str += [len, elem].pack("Ca*")
            names.update(entry.to_s => offset)
            offset += len
          end
        end
        [str, offset, names]
      end

      def valid?(name)
        raise ArgumentError, "Invalid FQDN: #{name}" unless name =~ /^([a-z0-9]([-a-z0-9]*[a-z0-9])?\.)+((a[cdefgilmnoqrstuwxz]|aero|arpa)|(b[abdefghijmnorstvwyz]|biz)|(c[acdfghiklmnorsuvxyz]|cat|com|coop)|d[ejkmoz]|(e[ceghrstu]|edu)|f[ijkmor]|(g[abdefghilmnpqrstuwy]|gov)|h[kmnrtu]|(i[delmnoqrst]|info|int)|(j[emop]|jobs)|k[eghimnprwyz]|l[abcikrstuvy]|(m[acdghklmnopqrstuvwxyz]|mil|mobi|museum)|(n[acefgilopruz]|name|net)|(om|org)|(p[aefghklmnrstwy]|pro)|qa|r[eouw]|s[abcdeghijklmnortvyz]|(t[cdfghjklmnoprtvwz]|travel)|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw])$/i

        name
      end
    end
  end
end
