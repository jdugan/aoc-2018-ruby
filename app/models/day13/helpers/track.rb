module Day13
  module Helpers
    Track = Struct.new(:x, :y, :symbol, :siblings) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ATTRIBUTES ==============================

      def ascii
        symbol.ord
      end

      def id
        "#{ x }|#{ y }"
      end


      #========== DIRECTION IDS ===========================

      def east_id
        "#{ x + 1 }|#{ y }"
      end

      def north_id
        "#{ x }|#{ y - 1 }"
      end

      def south_id
        "#{ x }|#{ y + 1 }"
      end

      def west_id
        "#{ x - 1 }|#{ y }"
      end

    end
  end
end
