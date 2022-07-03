module Day16
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      emulator.interrogate
    end


    def p2
      emulator.run
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
