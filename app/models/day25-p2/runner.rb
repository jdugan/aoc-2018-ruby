module Day25
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      calculator.number_of_constellations
    end


    def p2
      # noop
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def calculator
      @calculator ||= Helpers::Calculator.new(data)
    end

  end
end
