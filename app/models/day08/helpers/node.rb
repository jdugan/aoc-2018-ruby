module Day08
  module Helpers
    class Node < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :header
      attr_accessor :parent
      attr_accessor :children
      attr_accessor :metadata


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== CALCULATIONS ============================

      def simple_value
        metadata.sum + children.map(&:simple_value).sum
      end

      def complex_value
        if barren?
          metadata.sum
        else
          indices = metadata.map { |n| n - 1 }.reject { |n| n < 0 }
          kids    = indices.map { |i| children[i] }.compact
          kids.map(&:complex_value).sum
        end
      end


      #======== STATE HELPERS =============================

      def barren?
        expected_children == 0
      end

      def expected_children
        header.first
      end

      def expected_metadata
        header.last
      end

      def fertile?
        !neutered?
      end

      def filled?
        metadata.size == expected_metadata
      end

      def neutered?
        children.size == expected_children
      end

      def valid?
        neutered? && filled?
      end

    end
  end
end
