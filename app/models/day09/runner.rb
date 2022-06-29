module Day09
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      game.play(max_players, max_marble)
      game.winning_score
    end


    def p2
      game.play(max_players, max_marble*100)
      game.winning_score
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def game
      @game ||= Helpers::Game.new
    end


    #========== HELPERS ===================================

    def inputs
      @inputs ||= begin
        regex  = Regexp.new('(\d+) players; last marble is worth (\d+) points')
        inputs = raw_data.first.split(regex).slice(1,2).map(&:to_i)
      end
    end

    def max_marble
      @max_marble ||= inputs.last
    end

    def max_players
      @max_players ||= inputs.first
    end

  end
end
