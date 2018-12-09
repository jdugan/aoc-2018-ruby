module Day04
  module Helpers
    Schedule = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def frequent_checksum
        g = guards.sort_by(&:favorite_count).last
        g.id * g.favorite_minute
      end

      def total_checksum
        g = guards.sort_by(&:total_sleep).last
        g.id * g.favorite_minute
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      #private

      #========== COLLECTIONS =============================

      def guards
        @guards ||= begin
          gh = shifts.reduce({}) do |hash, shift|
            gid = shift.guard_id
            hash[gid] ||= []
            hash[gid] << shift
            hash
          end
          gh.reduce([]) do |arr, (k,v)|
            arr << Guard.new(k, v)
            arr
          end
        end
      end

      def shifts
        @shifts ||= begin
          regex = Regexp.new('\[(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2})\]')
          sched = data.sort.reduce({}) do |hash, s|
            parts = s.strip.split(regex).slice(1, 2)

            dt    = DateTime.strptime(parts.first, '%Y-%m-%d %H:%M')
            hrs   = dt.strftime('%H').to_i
            mins  = dt.strftime('%M').to_i
            yday  = dt.yday
            yday  = yday + 1    if hrs == 23

            hash[yday] ||= []
            hash[yday] << Event.new(mins, parts.last.strip)
            hash
          end
          sched.keys.sort.map { |k| Shift.new(k, sched[k]) }
        end
      end

    end
  end
end
