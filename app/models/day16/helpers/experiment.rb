module Day16
  module Helpers
    Experiment = Struct.new(:command, :history) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ATTRIBUTES ==============================

      def opcode_number
        @opcode_number ||= command.first
      end


      #========== HELPERS =================================

      def possible_opcode_names
        @matches ||= begin
          a = []
          watch.operation_names.each do |m|
            watch.registry = safe_initial
            watch.send(m, *inputs)
            if watch.registry === history.last
              a << m
            end
          end
          a
        end
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------

      #========== ATTRIBUTES ==============================

      def safe_initial
        Marshal.load(Marshal.dump(history.first))         # do not memoise!
      end


      #========== MEMOS ===================================

      def inputs
        @inputs ||= command.slice(1,3)
      end

      def watch
        @watch ||= Watch.new
      end

    end
  end
end
