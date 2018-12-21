module Day20
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

    def route_tree
      @route_tree ||= Helpers::RouteTree.new(data)
    end

  end
end
