module Day11
  class Runner < AbstractRunner

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
        serial = data.first.to_i
        Helpers::Grid.new(serial, 300)
      end
    end

  end
end
