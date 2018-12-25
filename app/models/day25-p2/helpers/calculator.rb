module Day25
  module Helpers
    Calculator = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def number_of_constellations
        constellations.size
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== MEMOS ===================================

      def constellations
        @constellations ||= begin
          id    = 0
          array = []

          data.each do |str|
            coords = str.strip.split(',').map(&:to_i)
            point  = Point.new(*coords)
            found  = []
            array.each do |c|
              if c.point_related?(point)
                found << c
              end
            end
            if found.empty?
              id = id + 1
              c  = Constellation.new(id, [point])
              array << c
            else
              ps = [point] + found.flat_map { |c| c.points }
              c  = found.shift
              c.points = ps
              found.each do |c|
                array.delete(c)
              end 
            end
          end

          array
        end
      end

    end
  end
end
