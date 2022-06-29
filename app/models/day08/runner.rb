module Day08
  class Runner < BaseRunner

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
      @tree ||= begin
        numbers = raw_data.first.split(' ').map(&:to_i)
        Helpers::Tree.new(numbers: numbers)
      end
    end

  end
end
