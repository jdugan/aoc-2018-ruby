module Day23
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      cave.greediest_count
    end


    def p2
      cave.best_distance
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
