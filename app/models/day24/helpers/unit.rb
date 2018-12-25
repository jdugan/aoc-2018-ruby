module Day24
  module Helpers
    Unit = Struct.new(:id, :hit_points) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== STATE HELPERS ===========================

      def alive?
        hit_points > 0
      end

      def dead?
        !alive?
      end

    end
  end
end
