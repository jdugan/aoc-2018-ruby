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
      @calculator ||= begin
        freqs = Array(data).map(&:to_i)
        Day01::Helpers::Calculator.new(freqs)
      end
    end

  end
end
