module Day14
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      game.last_ten
    end


    def p2
      game.recipes_before_run
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def game
      @game ||= Helpers::Game.new(data)
    end

  end
end
