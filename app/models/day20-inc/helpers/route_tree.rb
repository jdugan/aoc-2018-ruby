module Day20
  module Helpers
    RouteTree = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def something

      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== COLLECTIONS =============================

      def routes
        @routes ||= begin

        end
      end

      def tree
        @tree ||= begin
          rh  = {}
          str = data.first
          arr = str.slice(1, str.size - 2).split('')
          
          end
        end
      end

    end
  end
end
