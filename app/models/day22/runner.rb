module Day22
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      cave.risk_level
    end


    def p2
      # noop
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def cave
      @cave ||= Helpers::Cave.new(data)
    end

  end
end
