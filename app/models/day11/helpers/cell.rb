module Day11
  module Helpers
    Cell = Struct.new(:x, :y, :power, :sum) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

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
