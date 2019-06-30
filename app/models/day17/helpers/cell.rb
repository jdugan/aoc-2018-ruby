module Day17
  module Helpers
    Cell = Struct.new(:key, :source_key, :type) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== COORD HELPERS ===========================

      def x
        @x ||= key.split('|').first.to_i
      end

      def y
        @y ||= key.split('|').last.to_i
      end

      #========== KEY HELPERS =============================

      def east_key
        "#{ x + 1 }|#{ y }"
      end

      def north_key
        "#{ x }|#{ y - 1 }"
      end

      def south_key
        "#{ x }|#{ y + 1 }"
      end

      def west_key
        "#{ x - 1 }|#{ y }"
      end


      #========== STATE HELPERS ===========================

      def barrier?
        [:clay].include?(type)
      end

      def impassable?
        [:clay, :standing].include?(type)
      end

      def passable?
        [:running].include?(type)
      end

      def standing?
        type == :standing
      end

      def water?
        [:running, :standing].include?(type)
      end


      #========== VISUALISATION ===========================

      def to_s
        case type
          when :clay     then '#'
          when :running  then '|'
          when :spring   then '+'
          when :standing then '~'
          else '.'
        end
      end

    end
  end
end
