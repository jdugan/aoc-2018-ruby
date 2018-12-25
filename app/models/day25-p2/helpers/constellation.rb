module Day25
  module Helpers
    Constellation = Struct.new(:id, :points) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== STATE HELPERS ===========================

      def constellation_related?(constellation)
        points.any? do |p|
          constellation.point_related?(p)
        end
      end

      def point_related?(point)
        points.any? { |p| p.manhattan(point) <= 3 }
      end

    end
  end
end
