module Day23
  module Helpers
    Cave = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def best_distance
        bb = best_bots.sort_by(&:last).last
        bp = bb.first
        br = bb.last

        bp.x.abs + bp.y.abs + bp.z.abs - br
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

      def bots
        @bots ||= begin
          id = 0
          data.map do |str|
            regexp = Regexp.new('^pos=<(-?\d+),(-?\d+),(-?\d+)>,\s+r=(\d+)$')
            inputs = str.split(regexp).slice(1, 4).map(&:to_i)
            coords = inputs.first(3)
            radius = inputs.last
            id     = id + 1

            Bot.new(id, Point.new(*coords), radius)
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
