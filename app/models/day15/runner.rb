module Day15
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      game.load_data
      # game.battle_royale
    end


    def p2
      # noop
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
