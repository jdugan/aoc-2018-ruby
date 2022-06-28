module Day06
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      # calculator.danger_visualization
      calculator.danger_area
    end


    def p2
      # calculator.safe_visualization
      calculator.safe_area
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    #========== OBJECTS ===================================

    def calculator
      @calculator ||= Helpers::Calculator.new(data, safe_limit)
    end


    #========== HELPERS ===================================

    def safe_limit
      @safe_limit ||= 10000
    end

  end
end
