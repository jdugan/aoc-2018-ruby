module Day21
  module Helpers
    Emulator = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def shortest_r0
        w = Watch.new(ip: ip, registry: [0, 0, 0, 0, 0, 0])
        while w.ip_value != 28
          cmd  = commands[w.ip_value]
          w.send(*cmd)
          w.increment_ip_value!
        end
        w.registry[3]
      end

      def longest_r0
        a = []
        d = false
        n = 0
        w = Watch.new(ip: ip, registry: [0, 0, 0, 0, 0, 0])

        while d == false
          cmd = commands[w.ip_value]
          w.send(*cmd)
          w.increment_ip_value!

          if w.ip_value == 28
            n = n + 1
            r = w.registry[3]
            if a.include?(r)
              puts "Duplicate: #{ r }"
              d = true
            else
              a << r
            end
            if n % 500 == 0
              puts n
            end
          end
        end
        a.last
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
