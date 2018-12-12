module Day13
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      main.something
    end


    def p2
      main.something
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def main
      @main ||= Helpers::Main.new(data)
    end

  end
end
