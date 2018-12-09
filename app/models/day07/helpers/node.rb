module Day07
  module Helpers
    class Node

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      DELAYS ||= ('A'..'Z').to_a.freeze

      # attributes
      attr_reader :id
      attr_reader :parents
      attr_reader :children
      attr_reader :state
      attr_reader :consumed

      # constructor
      def initialize(hash)
        @id       = hash[:id]
        @parents  = []
        @children = []
        @state    = :available
        @consumed = false
      end


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def accept!
        @state = :accepted
        id
      end

      def consume!
        @state = :consumed
        id
      end

      def reset!
        @state = :available
      end


      #========== GETTERS =================================

      def delay
        DELAYS.index(id) + 1
      end


      #========== SETTERS =================================

      def add_child(node)
        @children << node  unless children.include?(node)
      end

      def add_parent(node)
        @parents << node  unless parents.include?(node)
      end


      #========== STATE HELPERS ===========================

      def accepted?
        state == :accepted
      end

      def available?
        (state == :available) && (parents.empty? || parents.all?(&:consumed?))
      end

      def consumed?
        state == :consumed
      end

    end
  end
end
