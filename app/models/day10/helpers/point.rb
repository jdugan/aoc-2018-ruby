module Day10
  module Helpers
    Point = Struct.new(:x, :y, :vx, :vy) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def backward!(steps=1)
        history[0] = { x: x, y: y }

        self[:x] = x - (vx * steps)
        self[:y] = y - (vy * steps)
      end

      def forward!(steps=1)
        history[0] = { x: x, y: y }

        self[:x] = x + (vx * steps)
        self[:y] = y + (vy * steps)
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------

      def history
        @history ||= begin
          [ { x: x, y: y } ]
        end
      end

    end
  end
end
