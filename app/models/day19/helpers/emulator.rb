module Day19
  module Helpers
    Emulator = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      # The routine is an elaborate method for summing the
      # factors of a number. We run the loop until we get
      # the fixed value in r4, then we can exit the loop and
      # just do some ordinary math.
      #
      def run(seed)
        w = Watch.new(ip: ip, registry: [seed, 0, 0, 0, 0, 0])
        while w.ip_value != 1
          cmd = commands[w.ip_value]
          w.send(*cmd)
          w.increment_ip_value!
        end
        fa = factorise(w.registry[4])
        fa.sum
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== HELPERS =================================

      def factorise(num)
        fa  = [1, num]
        (2..Integer.sqrt(num)).each do |i|
          if num % i == 0
            fa << i
            fa << num / i
          end
        end
        fa
      end


      #========== MEMOS ===================================

      def commands
        @commands ||= begin
          h = {}
          data.slice(1, data.size).each.with_index do |str, index|
            regex = Regexp.new('^(\w{4})\s+(\d+)\s+(\d+)\s+(\d+)$')
            parts = str.split(regex).slice(1, 4)
            name  = parts.shift

            h[index] = [name] + parts.map(&:to_i)
          end
          h
        end
      end

      def ip
        @ip ||= begin
          data.first.gsub('#ip', '').strip.to_i
        end
      end

    end
  end
end
