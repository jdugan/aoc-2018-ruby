module Day14
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      game.play_until_size(target_size + 10)
      game.scores.slice(target_size, 10)
    end


    def p2
      game.play_until_run(target_run)
      game.scores.index(target_run)
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def game
      @game ||= Helpers::Game.new
    end

    def target_size
      @target_size ||= raw_data.first.to_i
    end

    def target_run
      @target_run ||= raw_data.last.to_s
    end

  end
end
