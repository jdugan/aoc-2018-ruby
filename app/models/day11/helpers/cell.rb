module Day11
  module Helpers
    Cell = Struct.new(:x, :y, :serial) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def power
        @power ||= begin
          pl = rack_id * y
          pl = pl + serial
          pl = pl * rack_id
          pl = (pl / 100) % 10
          pl = pl - 5
        end
      end

      def power_area_map
        @power_area_map ||= {}
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      def rack_id
        @rack_id ||= x + 10
      end

    end
  end
end
