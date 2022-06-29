module Day15
  module Helpers
    class Square

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_accessor :x
      attr_accessor :y
      attr_accessor :symbol
      attr_accessor :siblings
      attr_accessor :warrior

      # constructor
      def initialize(opts={})
        @x        = opts.fetch(:x)
        @y        = opts.fetch(:y)
        @symbol   = opts.fetch(:symbol)
        @siblings = opts.fetch(:siblings, {})
        @warrior  = opts[:warrior]
      end


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ATTRIBUTES ==============================

      def id
        "#{ x }|#{ y }"
      end

      def east_id
        "#{ x + 1 }|#{ y }"
      end

      def north_id
        "#{ x }|#{ y - 1 }"
      end

      def south_id
        "#{ x }|#{ y + 1 }"
      end

      def west_id
        "#{ x - 1 }|#{ y }"
      end


      #========== PRINT HELPERS ===========================

      def print
        if warrior
          warrior.team
        else
          symbol
        end
      end


      #========== SIBLING HELPERS =========================

      def available_neighbors
        neighbors.select(&:available?)
      end

      def occupied_neighbors
        neighbors.select(&:occupied?)
      end

      def neighbors
        @neighbors ||= begin
          sqs  = siblings.values.compact.reject(&:wall?)
          sqs.sort    # always return squares in reading order
        end
      end


      #========== SORT HELPERS ============================

      def reading_index
        [y, x]
      end


      #========== STATE HELPERS ===========================

      def available?
        !wall? && !occupied?
      end

      def occupied?
        warrior.present? && warrior.alive?
      end

      def wall?
        symbol == '#'
      end


      #========== UTILITY =================================

      def <=>(other)
        reading_index <=> other.reading_index
      end

    end
  end
end
