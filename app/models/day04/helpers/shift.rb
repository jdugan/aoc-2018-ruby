module Day04
  module Helpers
    Shift = Struct.new(:id, :data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ATTRIBUTES ==============================

      def guard_id
        @guard_id ||= guard_event.guard_id
      end


      #========== CALCULATIONS ============================

      def sleep_length
        @sleep_length ||= sleep_minutes.size
      end

      def sleep_minutes
        @sleep_minutes ||= begin
          mins = []
          sleep_events.each_slice(2) do |se, we|
            sm = se.min
            wm = we.min
            mins << (sm..wm-1).to_a
          end
          mins.flatten
        end
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== COLLECTIONS =============================

      def events
        @events ||= begin
          ge = data.shift
          se = data
          sm = se.first.min rescue 45     # some guards don't sleep
          if ge.min > sm
            ge.min = ge.min - 60
          end
          se.unshift(ge)
        end
      end


      #========== EVENT HELPERS ===========================

      def guard_event
        @guard_event ||= events.select { |e| e.guard? }.first
      end

      def sleep_events
        @sleep_events ||= events.reject { |e| e.guard? }
      end

    end
  end
end
