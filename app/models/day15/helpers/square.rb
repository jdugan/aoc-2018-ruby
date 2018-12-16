module Day15
  module Helpers
    Square = Struct.new(:x, :y, :symbol, :siblings, :warrior) do

      #========== ATTRIBUTES ==============================

      def id
        "#{ x }|#{ y }"
      end

      def east_id
        "#{ x + 1 }|#{ y }"
      end

      def north_id
        "#{ x }|#{ y - 1 }"
      end

      def south_id
        "#{ x }|#{ y + 1 }"
      end

      def west_id
        "#{ x - 1 }|#{ y }"
      end


      #========== PRINT HELPERS ===========================

      def inspect
        h = {
          x:        x,
          y:        y,
          symbol:   symbol,
          siblings: {
            e: siblings['e'] ? siblings['e'].id : nil,
            n: siblings['n'] ? siblings['n'].id : nil,
            s: siblings['s'] ? siblings['s'].id : nil,
            w: siblings['w'] ? siblings['w'].id : nil
          },
          warrior:  warrior ? { id: warrior.id, team: warrior.team } : nil
        }
      end

      def print
        if warrior
          warrior.team
        else
          symbol
        end
      end


      #========== STATE HELPERS ===========================

      def available?
        !wall? && !occupied?
      end

      def occupied?
        !warrior.nil?
      end

      def wall?
        symbol == '#'
      end

    end
  end
end
