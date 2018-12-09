module Day04
  module Helpers
    Event = Struct.new(:min, :action) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ATTRIBUTES ==============================

      def guard_id
        regex = Regexp.new('^Guard #(\d+)')
        action.split(regex).slice(1, 1).first.to_i
      end


      #========== STATE HELPERS ===========================

      def guard?
        action.include?('Guard')
      end

      def sleeps?
        action.include?('asleep')
      end

      def wake?
        action.include?('wakes')
      end

    end
  end
end
