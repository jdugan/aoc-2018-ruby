module Day06
  module Helpers
    class Calculator < Tableless

      #------------------------------------------------------
      # Configuration
      #------------------------------------------------------

      attr_accessor :grid
      attr_accessor :safe_limit


      #------------------------------------------------------
      # Public Methods
      #------------------------------------------------------

      #========== CALCULATIONS ==============================

      def danger_area
        danger_area_map.values.max
      end

      def safe_area
        grid.analysis.values.select { |v| v[:safe] < safe_limit }.size
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== HELPERS =================================

      def danger_area_map
        @danger_area_map ||= begin
          keys  = grid.corner_keys
          ids   = keys.map { |k| grid.analysis[k][:danger][:id] }

          grid.analysis.reduce({}) do |hash, (k, v)|
            dh = v[:danger]
            id = dh[:id]

            unless ids.include?(id)
              unless dh[:tied]
                hash[id] = (hash[id] || 0) + 1
              end
            end
            hash
          end
        end
      end

    end
  end
end
