module Day11
  module Helpers
    Grid = Struct.new(:serial) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def largest_defined(size)
        min    = 0
        max    = 300 - size
        xs = (min..max).to_a
        ys = (min..max).to_a

        answer = nil
        area   = power_area_min(size) - 1
        xs.product(ys).each do |x, y|
          pa = power_area(x, y, size)
          if pa > area
            answer = [x + 1, y + 1, size, pa]       # show offset values
            area   = pa
          end
        end

        answer
      end

      # This doesn't complete in a reasonable time, but the answer is correct.
      # The best result is near the square root of grid edge size, which I
      # suspect is not a coincidence. Probably a mathematical strategy is
      # possible here.
      #
      # I imagine I could devise a smarter strategy around how I calculate
      # the power area, too.  Some tiling strategy?  Perfect squares?
      #
      def largest_undefined
        min    = 1
        max    = 300
        sizes = (min..max).to_a

        answer = nil
        area   = power_area_min(300) - 1
        sizes.each do |size|
          sa = largest_defined(size)
          puts "#{ size }: #{ sa.inspect } (#{ sa.last })"
          if sa.last > area
            answer = sa
            area   = sa.last
          end
          if sa.last <= 0
            puts 'non-positive best: probability cliff past'
            break
          end
        end

        answer
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== CALCULATIONS ============================

      # def power_area(x, y, size)
      #   begin
      #     c  = cell(x, y)
      #     unless pa = c.power_area_map[size]
      #       os = size - 1
      #       xs = (x..x+os).to_a
      #       ys = (y..y+os).to_a
      #       ps = xs.product(ys).map do |x, y|
      #         cell(x, y).power
      #       end
      #       c.power_area_map[size] = pa = ps.sum         # returns sum
      #     end
      #     pa
      #   rescue
      #     power_area_min(size) - 1
      #   end
      # end

      def power_area(x, y, size)
        c  = cell(x, y)
        unless pa = c.power_area_map[size]
          pa = case
              when (size == 1)
                c.power
              when (size > 1) && (x < 300 - size) && (y < 300 - size)
                os = size - 1
                pa = power_area(x, y, os)

                xs = [x+os]
                ys = (y..y+os).to_a
                px = xs.product(ys).map do |x, y|
                  cell(x, y).power
                end

                xs = (x..x+os-1).to_a
                ys = [y+os]
                py = xs.product(ys).map do |x, y|
                  cell(x, y).power
                end

                c.power_area_map[size] = pa + px.sum + py.sum
              else
                power_area_min(size)
              end
        end
        pa
      end

      def power_area_max(size)
        (size * size) * 4
      end

      def power_area_min(size)
        (size * size) * -5
      end


      #========== GETTERS =================================

      def cell(x, y)
        matrix[x][y]
      end

      def matrix
        @matrix ||= begin
          Array.new(300).fill do |x|
            Array.new(300).fill do |y|
              c = Cell.new(x+1, y+1, serial)
              c.power
              c
            end
          end
        end
      end

    end
  end
end
