module Day04
  module Helpers
    class Schedule < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :shifts


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
      private

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
            arr << Guard.new(id: k, shifts: v)
            arr
          end
        end
      end

    end
  end
end
