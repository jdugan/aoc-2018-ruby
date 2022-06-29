module Day11
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      coords = grid.largest_defined(3).first(2)
      coords.join(",")
    end


    def p2
      coords = grid.largest_undefined.first(3)
      coords.join(",")
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def grid
      @grid ||= begin
        Helpers::Grid.new(serial: raw_data.first.to_i, dimension: 300)
      end
    end

  end
end
