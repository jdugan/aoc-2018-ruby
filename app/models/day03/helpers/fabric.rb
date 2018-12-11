module Day03
  module Helpers
    Fabric = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def overlapped_coords
        coord_map.select { |k,v| v.size > 1 }
      end

      def unencumbered_pattern_id
        pp_ids = patterns.map(&:id)
        oc_ids = overlapped_coords.values.flatten.uniq
        (pp_ids - oc_ids).first
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      def coord_map
        @coord_map ||= begin
          patterns.reduce({}) do |result, p|
            p.keys.each do |k|
              result[k] ||= []
              result[k] << p.id
            end
            result
          end
        end
      end

      def patterns
        @patterns ||= begin
          data.map do |s|
            regex = Regexp.new('^\#(\d+) @ (\d+),(\d*): (\d+)x(\d+)$')
            parts = s.split(regex).slice(1, 5).map(&:to_i)

            Pattern.new(*parts)
          end
        end
      end

    end
  end
end
