module Day06
  class Runner < BaseRunner

    #------------------------------------------------------
    # Configuration
    #------------------------------------------------------

    SAFE_LIMIT ||= 10000


    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      calculator.danger_area
    end


    def p2
      calculator.safe_area
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    #========== OBJECTS ===================================

    def calculator
      @calculator ||= begin
        Helpers::Calculator.new(grid: grid, safe_limit: SAFE_LIMIT)
      end
    end

    def grid
      @grid ||= begin
        points = raw_data.map.with_index do |str, id|
          coords = str.split(',').map(&:to_i)
          Helpers::Point.new(id: id, coords: coords)
        end
        Helpers::Grid.new(points: points)
      end
    end

  end
end
