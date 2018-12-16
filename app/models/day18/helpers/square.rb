module Day18
  module Helpers
    Square = Struct.new(:x, :y, :symbol, :value, :sum) do

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # constants
      WEIGHTS ||= { '#' => 100,
                    '|' => 10,
                    '.' => 1 }.freeze


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def evaluate!
        self[:value] = WEIGHTS[symbol]
      end

      def next!(previous, current)
        if ns = next_state(previous)
          transition!(symbol, ns, previous, current)
        end
      end

      def transition!(ps, ns, previous, current)
        pv = WEIGHTS[ps]
        nv = WEIGHTS[ns]
        dv = nv - pv

        self[:symbol] = ns
        self[:value]  = nv
        adjacent_squares(current).each do |sq|
          sq.sum = sq.sum - pv + nv
        end
      end


      #========== GRID HELPERS ============================

      def adjacent_squares(snapshot)
        coords = adjacent_coords(snapshot)
        coords.map { |x, y| snapshot[y][x] }.compact
      end


      #========== STATE HELPERS ===========================

      def lumberyard?
        symbol == '#'
      end

      def open?
        symbol == '.'
      end

      def trees?
        symbol == '|'
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      def next_state(squares)
        sq = squares[y][x]
        lw = WEIGHTS['#']
        tw = WEIGHTS['|']

        lc = sq.sum / lw
        tc = (sq.sum % lw) / tw
        oc = sq.sum % tw

        ns = case
              when (open? && tc > 2)
                '|'
              when (trees? && lc > 2)
                '#'
              when (lumberyard? && (lc == 0 || tc == 0))
                '.'
              else
                nil
              end
      end


      #========== MEMOS ===================================

      def adjacent_coords(snapshot)
        @adjacent_coords ||= begin
          xlimit = snapshot.first.size
          ylimit = snapshot.size

          xs = (x-1..x+1).to_a
          ys = (y-1..y+1).to_a

          xs.product(ys).reject do |x1, y1|
            (x1 < 0 || x1 >= xlimit) ||     # out of range: x
            (y1 < 0 || y1 >= ylimit) ||     # out of range: y
            (x1 == x && y1 == y)            # self
          end
        end
      end

    end
  end
end
