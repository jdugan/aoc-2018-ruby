module Day17
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      emulator.water_table
    end


    def p2
      # noop
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
