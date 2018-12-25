module Day15
  module Helpers
    Game = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def load_data
        puts ''
        puts board['5|2'].warrior.send(:adjacent_opponent)
        puts '-'
      end

      def battle_royale
        reset!
        turns = 0
        while multiple_teams?
          reset_order!
          warriors.each do |w|
            unless w.has_target?
              ats = available_targets_for(w)
              unless ats.empty?
                sps = shortest_paths_for(w)
                w.move!(sps)
              end
            end
            w.attack!
            break       if victory?
          end
          turns = turns + 1
        end

        turns  = turns - 1      # only count full turns
        health = warriors.map(&:health).sum

        turns * health
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== ACTIONS =================================

      def reset!
        @board    = nil
        @warriors = nil
      end

      def reset_order!
        @warriors = warriors.reject!(&:dead?).sort!
      end


      #========== GAME HELPERS ============================

      def available_targets_for(warrior)
        wt = warrior.team
        oa = warriors.select { |o| o.targetable? && !o.same_team?(wt) }
      end

      def multiple_teams?
        warriors.map(&:team).uniq.size > 1
      end

      def shortest_paths_for(warrior)
        # dijkstra here
        # array of arrays of squares?
      end

      def targets?(current)
        warriors.select { |w| w.alive? && !current.same_team?(w.team) }
      end


      #========== MEMOS ===================================

      def board
        @board ||= begin
          board = {}
          wid   = 0
          data.each.with_index do |str, y|
            sqs = str.strip.split('').each.with_index do |sym, x|
              case sym
              when '#', '.'
                warrior = nil
              else
                wid     = wid + 1
                warrior = Warrior.new(wid, sym, 3, 200, nil)
                sym     = '.'
              end
              square         = Square.new(x, y, sym, {}, warrior)
              warrior.square = square if warrior

              board[square.id] = square
            end
          end
          board.values.each do |sq|
            sq.siblings['e'] = board[sq.east_id]
            sq.siblings['n'] = board[sq.north_id]
            sq.siblings['s'] = board[sq.south_id]
            sq.siblings['w'] = board[sq.west_id]
          end
          board
        end
      end

      def warriors
        @warriors ||= begin
          wa = []
          board.each.with_index do |ya, y|
            ya.each.with_index do |sq, x|
              if sq.warrior
                wa << sq.warrior
              end
            end
          end
          wa
        end
      end

    end
  end
end
