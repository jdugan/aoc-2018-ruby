module Day23
  module Helpers
    Point = Struct.new(:x, :y, :z) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== CALCULATIONS ============================

      def manhattan(bot)
        vx = (x - bot.x).abs
        vy = (y - bot.y).abs
        vz = (z - bot.z).abs
        vx + vy + vz
      end

    end
  end
end
