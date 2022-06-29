module Day08
  module Helpers
    class Tree < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :numbers


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def root
        @root ||= begin
          nums   = Marshal.load(Marshal.dump(numbers))  # make a copy
          header = nums.shift(2)
          root   = Node.new(header: header, parent: nil, children: [], metadata: [])
          add_children(nums, root)
          root
        end
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== ACTIONS =================================

      def add_children(nums, node)
        if node.neutered?
          node.metadata = nums.shift(node.expected_metadata)
          if node.parent
            node.parent.children << node
            add_children(nums, node.parent)
          end
        else
          header = nums.shift(2)
          child  = Node.new(header: header, parent: node, children: [], metadata: [])
          add_children(nums, child)
        end
      end

    end
  end
end
