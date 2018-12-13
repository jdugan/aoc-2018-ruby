module Day13
  module Helpers
    Traffic = Struct.new(:data) do

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # constants
      CAR_SYMBOLS ||= ['^', '>', 'v', '<'].freeze
      DIRECTIONS  ||= ['n', 'e', 's', 'w'].freeze


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def first_accident
        reset!
        while crash_positions.empty?
          simple_move!
        end
        crash_positions.first
      end

      def last_car_standing
        reset!
        while cars.size > 1
          complex_move!
        end
        cars.first.position
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== ACTIONS =================================

      def remove_crashes!
        if crash_positions.present?
          crash_positions.each do |cp|
            id   = cp.join('|')
            cars.reject! { |c| c.position_id == id }
          end
        end
      end

      def simple_move!
        sort_cars!
        cars.each(&:move!)
      end

      def complex_move!
        sort_cars!
        ids = cars.map(&:id)
        ids.each do |id|
          if car = cars.find { |c| c.id == id }
            car.move!
            remove_crashes!
          end
        end
      end

      def reset!
        @cars   = nil
        @state  = nil
      end

      def sort_cars!
        cars.sort! { |a,b| a.position <=> b.position }
      end


      #========== COLLECTIONS =============================

      def cars
        @cars ||= state[:cars]
      end


      #========== DATA ====================================

      def state
        @state ||= begin
          verts     = [CAR_SYMBOLS[0], CAR_SYMBOLS[2]]
          car_id    = 0
          cars      = []
          track_map = {}
          data.each_with_index do |str, y|
            str.split('').each_with_index do |char, x|
              unless char == ' '
                if CAR_SYMBOLS.include?(char)
                  tchar   = verts.include?(char) ? '|' : '-'
                  track   = Track.new(x, y, tchar, {})
                  dir     = CAR_SYMBOLS.index(char)
                  ds      = DIRECTIONS[dir]
                  car_id  = car_id + 1
                  cars   << Car.new(car_id, track, ds, 0)
                else
                  track = Track.new(x, y, char, {})
                end
                track_map[track.id] = track
              end
            end
          end
          track_map.values.each do |t|
            case t.ascii
            when 43  # +
              t.siblings['n'] = track_map.fetch(t.north_id)
              t.siblings['e'] = track_map.fetch(t.east_id)
              t.siblings['s'] = track_map.fetch(t.south_id)
              t.siblings['w'] = track_map.fetch(t.west_id)
            when 45  # -
              t.siblings['e'] = track_map.fetch(t.east_id)
              t.siblings['w'] = track_map.fetch(t.west_id)
            when 47  # /
              ti = track_map[t.south_id]
              if ti && [43, 124].include?(ti.ascii)
                t.siblings['e'] = track_map.fetch(t.east_id)
                t.siblings['s'] = track_map.fetch(t.south_id)
              else
                t.siblings['n'] = track_map[t.north_id]
                t.siblings['w'] = track_map[t.west_id]
              end
            when 92  # \
              ti = track_map[t.north_id]
              if ti && [43, 124].include?(ti.ascii)
                t.siblings['n'] = track_map.fetch(t.north_id)
                t.siblings['e'] = track_map.fetch(t.east_id)
              else
                t.siblings['s'] = track_map.fetch(t.south_id)
                t.siblings['w'] = track_map.fetch(t.west_id)
              end
            when 124 # |
              t.siblings['n'] = track_map.fetch(t.north_id)
              t.siblings['s'] = track_map.fetch(t.south_id)
            end
          end
          { cars: cars, tracks: track_map }
        end
      end


      #========== HELPERS =================================

      def car_positions
        cars.map(&:position)
      end

      def car_position_map
        car_positions.reduce({}) do |hash, cp|
          k = cp.join('|')
          hash[k] ||= 0
          hash[k]   = hash[k] + 1
          hash
        end
      end

      def crash_positions
        car_position_map.select { |k,v| v > 1 }.map do |pair|
          pair.first.split('|').map(&:to_i)
        end
      end

    end
  end
end
