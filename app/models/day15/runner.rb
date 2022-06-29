module Day15
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      opts = default_options.merge({ elf_strength: 3 })
      game = Helpers::Game.new(opts)

      score, _ = game.battle_royale
      score
    end


    def p2
      elf_strength = 22
      elf_score    = nil

      while elf_score.nil?
        elf_strength = elf_strength + 1

        opts = default_options.merge({ elf_strength: elf_strength })
        game = Helpers::Game.new(opts)

        score, elf_died = game.battle_royale(true)
        if !elf_died
          elf_score = score
        end
      end

      elf_score
    end


    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------
    private

    def default_options
      { initial_state: raw_data, goblin_strength: 3 }
    end

  end
end
