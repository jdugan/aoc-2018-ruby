module Day11
  module Helpers
    Grid = Struct.new(:serial, :dimension) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def largest_defined(size)
        min = 0
        max = dimension - size
        xs  = (min..max).to_a
        ys  = (min..max).to_a

        answer = nil
        area   = power_area_min(size) - 1
        xs.product(ys).each do |x, y|
          pa = power_area(x, y, size)
          if pa > area
            answer = [x+1, y+1, size, pa]       # show offset values
            area   = pa
          end
        end

        answer
      end

      def largest_undefined
        min    = 1
        max    = dimension
        sizes = (1..dimension).to_a

        answer = nil
        area   = power_area_min(300) - 1
        sizes.each do |size|
          sa = largest_defined(size)
          puts "#{ size }: #{ sa.inspect } (#{ sa.last })"
          if sa.last > area
            answer = sa
            area   = sa.last
          end
          if sa.last <= 0     # negative powers are more frequent; once a max sum is
            break             # negative, we've past a probability cliff (the larger the
          end                 # square, the more likely the sum will be negative).
        end

        answer
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== CALCULATIONS ============================

      def power_area(x, y, size)
        os = size - 1
        a  = cell(x-1,  y-1).sum    rescue 0
        b  = cell(x+os, y-1).sum    rescue 0
        c  = cell(x-1,  y+os).sum   rescue 0
        d  = cell(x+os,  y+os).sum  rescue 0

        d - c - b + a
      end

      def power_area_max(size)
        (size * size) * 4
      end

      def power_area_min(size)
        (size * size) * -5
      end


      #========== GETTERS =================================

      def cell(x, y)
        if (x >= 0) && (y >= 0)
          table[x][y]
        end
      end

      def table
        @table ||= begin
          xh = {}
          t  = Array.new(dimension).fill do |x|
            Array.new(dimension)
          end
          t.each_with_index do |r, x|
            r.size.times do |y|
              # calculate power
              p = (x + 11) * (y + 1)
              p = p + serial
              p = p * (x + 11)
              p = (p / 100) % 10
              p = p - 5

              # calculate summed area
              xa = (x > 0) ? t[x-1][y].sum : 0
              if y > 0
                ya    = xh[y-1].to_i
                xh[y] = ya + p
              else
                ya = 0
              end
              sa = xa + ya + p

              # return cell
              t[x][y] = Cell.new(x+1, y+1, p, sa)
            end
          end
          t
        end
      end

    end
  end
end
