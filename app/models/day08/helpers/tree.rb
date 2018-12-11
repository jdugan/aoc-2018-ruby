module Day08
  module Helpers
    Tree = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def root
        @root ||= begin
          nums   = Marshal.load(Marshal.dump(numbers))  # make a copy
          header = nums.shift(2)
          root   = Node.new(header, nil, [], [])
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
          child  = Node.new(header, node, [], [])
          add_children(nums, child)
        end
      end


      #========== DATA ====================================

      def numbers
        @numbers ||= begin
          data.first.split(' ').map(&:to_i)
        end
      end

    end
  end
end
