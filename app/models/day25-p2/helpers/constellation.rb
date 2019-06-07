module Day25
  module Helpers
    Constellation = Struct.new(:id, :points) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== STATE HELPERS ===========================

      def point_related?(point)
        points.any? { |p| p.manhattan(point) <= 3 }
      end

    end
  end
end
