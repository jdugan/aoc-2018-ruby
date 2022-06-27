module Day17
  module Helpers
    Emulator = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def flowing_size
        grid.water_count
      end

      def retained_size
        grid.standing_count
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== MEMOS ===================================

      def grid
        @grid ||= begin
          g = Grid.new(data)
          g.flow!
          # g.print
          g
        end
      end

    end
  end
end
