module Day24
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      emulator.winning_units
    end


    def p2
      emulator.boost!(42)
      emulator.winning_units
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def emulator
      @emulator ||= Helpers::Emulator.new(data)
    end

  end
end
