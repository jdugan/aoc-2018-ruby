module Day11
  module Helpers
    class Cell < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :x
      attr_accessor :y
      attr_accessor :power
      attr_accessor :sum


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
