module Day11
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      grid.largest_defined(3)
    end


    def p2
      grid.largest_undefined
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def grid
      @grid ||= begin
        serial = data.first.to_i
        Helpers::Grid.new(serial)
      end
    end

  end
end
