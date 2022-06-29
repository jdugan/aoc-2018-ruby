module Day04
  module Helpers
    class Event < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :min
      attr_accessor :action


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
