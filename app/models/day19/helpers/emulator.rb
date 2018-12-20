module Day19
  module Helpers
    Emulator = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def run(seed)
        upper = commands.size
        w     = Watch.new(ip, [seed, 0, 0, 0, 0, 0])
        r0s   = [0]
        r0    = 0
        n     = 0

        while w.ip_value < upper && n < 1000
          cmd  = commands[w.ip_value]
          ps   = [n]
          ps  << "ip=#{ w.ip_value }"
          ps  << w.registry.inspect
          ps  << cmd.join(' ')

          w.send(*cmd)
          ps << w.registry.inspect
          puts ps.join(' ') # if w.ip_value == 10 #n >= 10800 && n <= 10900
          w.increment_ip_value!
          n = n + 1
          if w.registry[0] != r0
            r0 = w.registry[0]
            r0s << r0
          end
        end

        puts r0s.inspect
        w.registry.first
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

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
