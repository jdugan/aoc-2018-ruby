module Day15
  module Helpers
    class Game

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_accessor :initial_state
      attr_accessor :elf_strength
      attr_accessor :goblin_strength

      # constructor
      def initialize(opts={})
        @initial_state   = opts.fetch(:initial_state)
        @elf_strength    = opts.fetch(:elf_strength)
        @goblin_strength = opts.fetch(:goblin_strength)
      end


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def battle_royale(strict=false)
        # print(:initial) if printable

        # capture starting state
        initial_elf_count = elf_count

        # play game until victory
        turns = 0
        while multiple_teams?
          warriors.each do |w|
            # move & attack, if possible
            if w.alive?
              unless w.has_opponent?
                relocate_warrior!(w)
              end
              w.attack!
            end

            # count
            if w == warriors.last
              turns = turns + 1
              # print(turns) if printable
            elsif victory?
              break
            end
          end

          # if strict mode and any elf dies, stop
          if strict && initial_elf_count != elf_count
            break
          end

          reorder_warriors!
        end

        # determine score
        score    = turns * warriors.map(&:health).sum
        elf_died = initial_elf_count != elf_count

        # print(:final)
        # puts ''
        # puts '='*80
        # puts 'Summary'
        # puts '-'*80
        # puts "elf strength:  #{ elf_strength }"
        # puts "warrior count: #{ warriors.size }"
        # puts "warriors:      #{ warriors.map(&:health).inspect }"
        # puts "total health:  #{ total_health }"
        # puts "turns:         #{ turns }"
        # puts "winning score: #{ winning_score }"
        # puts "winning team:  #{ winning_team }"
        # puts "all survived?: #{ all_survived }"
        # puts '='*80
        # puts ''

        [ score, elf_died ]
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== DATA HELPERS ============================

      def squares
        @squares ||= begin
          warrior_id = 0
          hash       = {}

          initial_state.each.with_index do |str, y|
            str.strip.split('').each.with_index do |sym, x|
              case sym
              when '#', '.'
                square = Helpers::Square.new(x: x, y: y, symbol: sym)
              else
                warrior_id = warrior_id + 1
                strength   = sym == 'E' ? elf_strength : goblin_strength
                warrior    = Helpers::Warrior.new(id: warrior_id, team: sym, strength: strength)
                square     = Helpers::Square.new(x: x, y: y, symbol: '.', warrior: warrior)
                warrior.square = square
              end
              hash[square.id] = square
            end
          end

          hash.values.each do |sq|
            sq.siblings['e'] = hash[sq.east_id]
            sq.siblings['n'] = hash[sq.north_id]
            sq.siblings['s'] = hash[sq.south_id]
            sq.siblings['w'] = hash[sq.west_id]
          end

          hash
        end
      end

      def warriors
        @warriors ||= begin
          squares.values.map(&:warrior).compact
        end
      end


      #========== BATTLE HELPERS ==========================

      def calculate_step(warrior, targets)
        # build graph
        graph = DijkstraFast::Graph.new
        squares.values.select(&:available?).each do |s1|
          s1.available_neighbors.each do |s2|
            graph.add(s1.id, s2.id, distance: 1)
          end
        end

        # set defaults
        shortest_distance = 999999
        shortest_id       = ""

        # check paths from adjacent squares rather than
        # from warrior's square so we can control for
        # reading order when there are ties (because
        # collections of squares are always in reading
        # order).
        origin_ids = warrior.targetable_squares.sort.map(&:id)
        targets.sort.map(&:id).each do |target_id|
          origin_ids.each do |origin_id|
            begin
              distance, _  = graph.shortest_path(origin_id, target_id)
              if distance < shortest_distance
                shortest_distance = distance
                shortest_id       = origin_id
              end
            rescue DijkstraFast::NoPathExistsError
              # ignore
            end
          end
          hash
        end

        # return square (or nil)
        squares[shortest_id]
      end

      def relocate_warrior!(warrior)
        targets = targetable_squares_for(warrior)
        if targets.present?
          if square = calculate_step(warrior, targets)
            warrior.relocate!(square)
          end
        end
      end

      def reorder_warriors!
        @warriors = warriors.reject(&:dead?).sort
      end


      #========== PRINT HELPERS ===========================

      def print(turns)
        sqs  = squares.values
        xmax = sqs.map(&:y).max
        ymax = sqs.map(&:y).max
        matrix = Array.new(ymax + 1) { Array.new(xmax + 1) }
        sqs.each do |sq|
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


      #========== STATUS HELPERS ==========================

      def elf_count
        warriors.select { |w| w.elf? }.size
      end

      def multiple_teams?
        warriors.reject(&:dead?).map(&:team).uniq.size > 1
      end

      def victory?
        !multiple_teams?
      end


      #========== TARGET HELPERS ==========================

      def targetable_squares_for(current)
        targets_for(current).flat_map(&:targetable_squares).uniq
      end

      def targets_for(current)
        warriors.select { |w| w.alive? && w.enemy?(current) }
      end

    end
  end
end
