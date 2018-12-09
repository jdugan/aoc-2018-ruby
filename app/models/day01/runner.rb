module Day01
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      calculator.sum
    end

    def p2
      calculator.first_duplicate
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
