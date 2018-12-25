module Day17
  module Helpers
    Emulator = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def water_table
        grid_limits
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== MEMOS ===================================

      def grid
        @grid ||= begin
          regex = Regexp.new('^(x|y)=(\d+), (x|y)=(\d+)..(\d+)$')

          data.reduce({}) do |hash, str|
            dt1, dv1, dt2, dv2s, dv2f = str.strip.split(regex).slice(1, 5)
            if dt1 == 'x'
              xs = [dv1]
              ys = (dv2s..dv2f).to_a
            else
              ys = [dv1]
              xs = (dv2s..dv2f).to_a
            end

            xs.product(ys).each do |x, y|
              hash["#{ x }|#{ y }"] = '#'
            end
            hash
          end
        end
      end

      def grid_limits
        @grid_limits ||= begin
          xkeys, ykeys = grid.keys.sort.map{ |k| k.split('|').map(&:to_i) }.transpose
          
          { x: (xkeys.min..xkeys.max), y: (ykeys.min..ykeys.max) }
        end
      end

    end
  end
end
