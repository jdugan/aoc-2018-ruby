module Day10
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      sky.message
    end


    def p2
      sky.time
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def sky
      @sky ||= Helpers::Sky.new(data, 0)
    end

  end
end
