module Day08
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      tree.root.simple_value
    end


    def p2
      tree.root.complex_value
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
