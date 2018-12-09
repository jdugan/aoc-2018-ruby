module Day07
  module Helpers
    class Crew

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_reader :workers

      # constructor
      def initialize(hash)
        @workers = hash[:size].times.map { Worker.new }
      end


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== COLLECTIONS =============================

      def busy_workers
        workers.select(&:busy?)
      end

      def idle_workers
        workers.select(&:idle?)
      end


      #========== STATE HELPERS ===========================

      def busy?
        busy_workers.size > 0
      end

    end
  end
end
