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

      #========== ACTIONS =================================

      def shrink(multiple)
        x1 = x / multiple
        y1 = y / multiple
        z1 = z / multiple
        r1 = radius / multiple

        Bot.new(x: x1, y: y1, z: z1, radius: r1)
      end


      #========== COLLECTIONS =============================

      def coords
        [x, y, z]
      end

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

      def manhattan_to_origin
        x.abs + y.abs + z.abs
      end

    end
  end
end
