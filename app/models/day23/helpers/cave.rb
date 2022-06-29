module Day23
  module Helpers
    class Cave < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_accessor :bots


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def best_distance
        bh = bots.reduce({}) do |hash, bot|
          hash[bot.id] = bot.neighbours(bots).size
          hash
        end
        puts bh.inspect
        # bb = best_bots.sort_by(&:last).last
        # bp = bb[0]
        # br = bb[1]
        #
        # bp.x.abs + bp.y.abs + bp.z.abs - br
        # op = Point.new(0, 0, 0)
        # bp = best_points
        # bp.map { |p| p.manhattan(op) }.sort.first
      end

      def greediest_count
        gb = greediest_bot
        gb.neighbours(bots).size
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== MEMOS ===================================

      def best_bots
        @best_bots ||= begin
          bots.map do |b|
            [b.point, b.radius, b.neighbours(bots).size]
          end
        end
      end

      def greediest_bot
        @greediest_bot ||= begin
          bots.sort_by(&:radius).last
        end
      end

    end
  end
end
