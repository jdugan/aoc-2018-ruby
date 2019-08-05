module Day15
  module Helpers
    Game = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def battle_royale
        reset!
        turns = 0

        print(:initial)

        while multiple_teams?
          reset_order!
          warriors.each do |w|
            # move & attack, if possible
            if w.alive?
              unless w.has_opponent?
                dest_ids = targetable_squares_for(w).map(&:id)
                if dest_ids.present?
                  sid = w.calculate_step(dest_ids)
                  if sq = board[sid]
                    w.relocate!(sq)
                  end
                end
              end
              w.attack!
            end

            # count
            if w == warriors.last
              turns = turns + 1
              print(turns)
            else
              break if victory?
            end
          end
          break if turns == 2
        end

        reset_order!
        health = warriors.map(&:health).sum
        score  = health * turns

        print(:final)
        puts ''
        puts '='*80
        puts 'Summary'
        puts '-'*80
        puts "warriors: #{ warriors.map(&:health).inspect }"
        puts "health: #{ health }"
        puts "turns:  #{ turns }"
        puts "score:  #{ score }"
        puts '='*80
        puts ''

        [health, turns, score]
      end

      def print(turns)
        xmax = board.values.map(&:y).max
        ymax = board.values.map(&:y).max
        matrix = Array.new(ymax + 1) { Array.new(xmax + 1) }
        board.values.each do |sq|
          matrix[sq.y][sq.x] = sq.print
        end

        puts ''
        case turns
        when :initial
          puts "Initial State:"
        when :final
          puts "Final State:"
        else
          puts "After #{ turns } #{ 'Round'.pluralize(turns) }"
        end
        matrix.each do |row|
          puts row.join(' ')
        end
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
        @warriors = warriors.reject(&:dead?).sort
      end


      #========== GAME HELPERS ============================

      def multiple_teams?
        warriors.reject(&:dead?).map(&:team).uniq.size > 1
      end

      def targetable_squares_for(current)
        targets_for(current).flat_map(&:targetable_squares).uniq
      end

      def targets_for(current)
        warriors.select { |w| w.alive? && w.enemy?(current) }
      end

      def victory?
        !multiple_teams?
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
          board.values.map(&:warrior).compact
        end
      end

    end
  end
end
