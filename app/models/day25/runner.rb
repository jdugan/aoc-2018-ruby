module Day25
  class Runner < BaseRunner

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
      @calculator ||= Helpers::Calculator.new(raw_data)
    end

  end
end
