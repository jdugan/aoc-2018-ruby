module Day05
  class Runner < BaseRunner

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
      @nature ||= Helpers::Nature.new(polymer: raw_data.first)
    end

  end
end
