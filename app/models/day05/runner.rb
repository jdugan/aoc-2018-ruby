module Day05
  class Runner < AbstractRunner

    #--------------------------------------------------------
    # Public Methods
    #--------------------------------------------------------

    def p1
      nature.simple_reduction
    end


    def p2
      nature.complex_reduction
    end


    #--------------------------------------------------------
    # Private Methods
    #--------------------------------------------------------
    private

    def nature
      @nature ||= Helpers::Nature.new(data)
    end

  end
end
