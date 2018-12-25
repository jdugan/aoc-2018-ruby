module Day24
  module Helpers
    Army = Struct.new(:id, :name, :groups) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== COLLECTIONS =============================

      def units
        groups.flat_map(&:units)
      end


      #========== STATE HELPERS ===========================

      def alive?
        Array(groups).any?(&:alive?)
      end

      def dead?
        !alive?
      end

    end
  end
end
