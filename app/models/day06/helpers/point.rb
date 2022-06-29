module Day06
  module Helpers
    class Point < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :id
      attr_accessor :x
      attr_accessor :y


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ATTRIBUTES ==============================

      def coords=(coords)
        self.x = coords.first
        self.y = coords.last
      end

      def key
        "#{ x }|#{ y }"
      end


      #========== CALCULATIONS ============================

      def distance(other)
        dx = (x - other.x).abs
        dy = (y - other.y).abs
        dx + dy
      end

    end
  end
end
