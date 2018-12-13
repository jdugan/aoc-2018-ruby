module Day13
  module Helpers
    Car = Struct.new(:id, :track, :direction, :intersections) do

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # constants
      DIRECTIONS   ||= ['n', 'e', 's', 'w'].freeze
      TURN_OFFSETS ||= [-1, 0, -3].freeze


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def move!
        self[:track] = track.siblings[direction]
        orient!
      end

      def orient!
        case track.ascii
        when 43   # '+'
          ti = intersections % 3
          to = TURN_OFFSETS[ti]
          di = DIRECTIONS.index(direction)
          ds = DIRECTIONS[di + to]

          self[:direction]     = ds
          self[:intersections] = intersections + 1
        when 47   # '/'
          case direction
          when 'n'
            self[:direction] = 'e'
          when 'e'
            self[:direction] = 'n'
          when 's'
            self[:direction] = 'w'
          when 'w'
            self[:direction] = 's'
          end
        when 92   # '\'
          case direction
          when 'n'
            self[:direction] = 'w'
          when 'e'
            self[:direction] = 's'
          when 's'
            self[:direction] = 'e'
          when 'w'
            self[:direction] = 'n'
          end
        end

        direction
      end


      #========== ATTRIBUTES ==============================

      def position
        [track.x, track.y]
      end

      def position_id
        position.join("|")
      end

    end
  end
end
