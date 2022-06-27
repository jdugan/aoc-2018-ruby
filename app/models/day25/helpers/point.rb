module Day25
  module Helpers
    Point = Struct.new(:x, :y, :z, :t) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== CALCULATIONS ============================

      def manhattan(point)
        cx = (x - point.x).abs
        cy = (y - point.y).abs
        cz = (z - point.z).abs
        ct = (t - point.t).abs

        cx + cy+ cz + ct
      end


      #========== COMPARATORS =============================

      def <=>(other)
        [self.t, self.x, self.y, self.z] <=> [other.t, other.x, other.y, other.z]
      end

    end
  end
end
