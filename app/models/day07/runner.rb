module Day07
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      tree.linear_instructions
    end


    def p2
      tree.parallel_time(60, 5)     # step duration, worker pool size
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def tree
      @tree ||= Helpers::Tree.new(data)
    end

  end
end
