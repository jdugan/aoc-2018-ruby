module Day20
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      grid.most_doors
    end


    def p2
      grid.distant_rooms(1000)
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def grid
      @grid ||= begin
        expression = raw_data.first
        expression = expression.slice(1, expression.size - 2).downcase

        Helpers::Grid.new(expression: expression)
      end
    end

  end
end
