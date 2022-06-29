module Day14
  module Helpers
    class Game < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :positions
      attr_accessor :scores


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== PLAY ====================================

      def play_until_size(target_size)
        reset!

        while scores.size < target_size
          play_round!
        end
      end

      def play_until_run(target_run)
        reset!

        run_size    = target_run.size
        current_run = scores.dup

        while current_run.index(target_run).nil?
          scores      = play_round!
          current_run = (current_run + scores).last(20)
        end
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== HELPERS (PLAY) ==========================

      def play_round!
        # update scores
        new_scores = positions.map { |p| scores.at(p).to_i }.sum.to_s
        self.scores.concat(new_scores)

        # update positions
        score_size = scores.size
        self.positions = positions.map do |p|
          steps = scores.at(p).to_i + 1
          (p + steps) % score_size
        end

        # return delta
        new_scores
      end


      #========== HELPERS (RESET) =========================

      def reset!
        self.positions = [0, 1]
        self.scores    = "37"
      end

    end
  end
end
