module Day24
  class Runner < BaseRunner

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
      @emulator ||= Helpers::Emulator.new(raw_data)
    end

  end
end
