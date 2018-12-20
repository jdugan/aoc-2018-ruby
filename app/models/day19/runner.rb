module Day19
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      emulator.run(0)
    end


    def p2
      emulator.run(1)
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
