module Day22
  module Helpers
    Cave = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def risk_level
        # print
        rl = 0
        (0..target_coords.last).to_a.each do |y|
          (0..target_coords.first).to_a.each do |x|
            rl = rl + squares[y][x].risk_level
          end
        end
        rl
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== ACTIONS =================================

      def print
        puts ''
        squares.each do |row|
          puts row.map(&:print).join
        end
        puts ''
      end


      #========== MEMOS ===================================

      def depth
        @depth ||= begin
          data.first.gsub('depth: ', '').strip.to_i
        end
      end

      def squares
        @squares ||= begin
          tx = target_coords.first
          ty = target_coords.last
          mx = tx + 20
          my = ty + 20

          # basic fill; set location types
          sqs = Array.new(my+1).fill { Array.new(mx+1) }
          (0..my).to_a.each do |y|
            (0..mx).to_a.each do |x|
              sqs[y][x] = Square.new(x, y, depth, :normal)
            end
          end
          sqs[0][0].mouth!
          sqs[ty][tx].target!

          # set geologic indices
          sqs.each.with_index do |row, y|
            row.each.with_index do |sq, x|
              sq.geologic_index =
                case
                when sq.mouth? || sq.target?
                  0
                when sq.x == 0
                  sq.y * 48271
                when sq.y == 0
                  sq.x * 16807
                else
                  xe = sqs[sq.y][sq.x-1].erosion_level
                  ye = sqs[sq.y-1][sq.x].erosion_level
                  xe * ye
                end
            end
          end
        end
      end

      def target_coords
        @target_coords ||= begin
          data.last.gsub('target: ', '').split(',').map { |s| s.strip.to_i }
        end
      end

    end
  end
end
