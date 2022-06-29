module Day03
  module Helpers
    class Fabric < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :patterns


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def overlapped_coords
        coord_map.select { |k,v| v.size > 1 }
      end

      def unencumbered_pattern_id
        pp_ids = Set.new(patterns.map(&:id))
        oc_ids = Set.new(overlapped_coords.values.flatten.uniq)
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

    end
  end
end
