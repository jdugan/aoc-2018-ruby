module Day08
  module Helpers
    class Tree

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_reader :numbers

      # constructor
      def initialize(hash)
        @numbers = hash[:numbers]
      end


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def root
        @root ||= begin
          nums   = numbers.map { |n| n }  # make a copy
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

    end
  end
end
