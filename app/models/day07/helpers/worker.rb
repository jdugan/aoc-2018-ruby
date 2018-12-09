module Day07
  module Helpers
    class Worker

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_reader :node
      attr_reader :wait

      # constructor
      def initialize
        @node = nil
        @wait = 0
      end


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def assign!(n, dur)
        if idle?
          n.accept!
          @node = n
          @wait = n.delay + dur
        end
      end

      def work!
        if busy?
          @wait = wait - 1
          if idle?
            status = [:idle, node.id]
            node.consume!
            @node = nil
          else
            status = [:busy, node.id]
          end
        else
          status = [:idle, nil]
        end
        status
      end


      #========== STATE HELPERS ===========================

      def busy?
        wait > 0
      end

      def idle?
        wait < 1
      end

    end
  end
end
