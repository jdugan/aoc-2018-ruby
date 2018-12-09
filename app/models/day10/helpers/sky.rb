module Day10
  module Helpers
    Sky = Struct.new(:data, :clock) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def message
        ps = message_points
        print(ps)
      end

      def time
        ps = message_points
        clock
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== ACTIONS =================================

      def backward!(steps=1)
        self[:clock] = clock - steps
        working_points.each { |p| p.backward!(steps) }
      end

      def forward!(steps=1)
        self[:clock] = clock + steps
        working_points.each { |p| p.forward!(steps) }
      end

      def print(points)
        mm = min_max(points)

        cx = mm[:max][:x] - mm[:min][:x] + 1
        cy = mm[:max][:y] - mm[:min][:y] + 1
        ox = 0 - mm[:min][:x]
        oy = 0 - mm[:min][:y]

        fabric = Array.new(cy).fill { Array.new(cx).fill { '.' } }
        points.each do |p|
          fabric[p.y + oy][p.x + ox] = '#'
        end

        puts ''
        fabric.each do |row|
          puts row.join(' ')
        end
        puts ''
        puts "clock: #{ clock }"
        puts ''
        puts ''
        nil
      end


      #========== CALCULATIONS ============================

      def height(points)
        mm = min_max(points)
        cy = mm[:max][:y] - mm[:min][:y] + 1
      end

      def min_max(points)
        xs = points.map(&:x).uniq.sort
        ys = points.map(&:y).uniq.sort

        { min: { x: xs.first, y: ys.first }, max: { x: xs.last, y: ys.last } }
      end


      #========== COLLECTIONS =============================

      def message_points
        # determine height change on movement
        oh = height(working_points)
        forward!
        nh = height(working_points)
        df = oh - nh

        # if height is large, determine steps to bring
        # height down to a reasonable level, do that
        # all at once, and reset nh
        if nh > 25
          remainder = nh % df
          safety    = 25 / df
          sh        = remainder + (safety * df)
          steps     = (nh - sh) /df
          forward!(steps)
          nh = sh
        end

        # now iterate carefully until height reverses
        oh = nh + 1
        while nh < oh do
          forward!
          oh = nh
          nh = height(working_points)
        end
        backward!
        working_points.map { |p| p }
      end

      def working_points
        @working_points ||= begin
          data.map do |str|
            regex = Regexp.new('^position=<(-?\s?\d*), (-?\s?\d*)> velocity=<(-?\s?\d*), (-?\s?\d*)>$')
            parts = str.split(regex).reject(&:blank?).map(&:to_i)

            Point.new(*parts)
          end
        end
      end

    end
  end
end
