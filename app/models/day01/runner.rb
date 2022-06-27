module Day01
  class Runner < BaseRunner

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
      @calculator ||= Helpers::Calculator.new(deltas: deltas)
    end

    def deltas
      @deltas ||= Array(raw_data).map(&:to_i)
    end

  end
end
