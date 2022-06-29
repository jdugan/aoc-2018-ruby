module Day10
  module Helpers
    class Point < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :x
      attr_accessor :y
      attr_accessor :vx
      attr_accessor :vy


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def backward!(steps=1)
        history[0] = { x: x, y: y }

        self.x = x - (vx * steps)
        self.y = y - (vy * steps)
      end

      def forward!(steps=1)
        history[0] = { x: x, y: y }

        self.x = x + (vx * steps)
        self.y = y + (vy * steps)
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      def history
        @history ||= begin
          [ { x: x, y: y } ]
        end
      end

    end
  end
end
