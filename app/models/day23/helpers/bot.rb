module Day23
  module Helpers
    class Bot < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_accessor :id
      attr_accessor :x
      attr_accessor :y
      attr_accessor :z
      attr_accessor :radius


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------


      #========== COLLECTIONS =============================

      def neighbours(bots)
        bots.select { |b| manhattan(b) <= radius }
      end


      #========== UTILITIES ===============================

      def manhattan(other)
        vx = (x - other.x).abs
        vy = (y - other.y).abs
        vz = (z - other.z).abs
        vx + vy + vz
      end

    end
  end
end
