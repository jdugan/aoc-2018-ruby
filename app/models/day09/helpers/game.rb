module Day09
  module Helpers
    class Game

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_reader :board
      attr_reader :players
      attr_reader :player_index
      attr_reader :marble_index

      # constructor
      def initialize
        @board        = nil
        @players      = nil
        @player_index = nil
        @marbles      = nil
        @marble_index = nil
      end


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== GAMEPLAY ================================

      def play(max_players, max_marble)
        reset(max_players)

        (1..max_marble).each do |marble|
          if marble % 10000 == 0                  # rudimentary progress bar
            puts marble
          end

          np = next_player
          m0 = board[marble_index]

          if special?(marble)
            m6 = walk(:left, m0, 6)
            m7 = walk(:left, m6, 1)
            m8 = walk(:left, m7, 1)

            np.score = np.score + marble + m7.id

            board.delete(m7.id)
            m8.right = m6.id
            m6.left  = m8.id
            nl = m6.id
          else
            m1 = walk(:right, m0, 1)
            m2 = walk(:right, m1, 1)
            board[marble] = Marble.new(marble, m1.id, m2.id)
            m1.right = marble
            m2.left  = marble
            nl = marble
          end

          record_player(np)
          record_location(nl)
        end
      end


      #========== SCORING =================================

      def winning_score
        players.map(&:score).sort.last
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== GAMEPLAY ================================

      def echo_board
        a = [0]
        s = board[0]
        while s.right != 0
          a << s.right
          s = board[s.right]
        end
        puts a.join(' ')
      end

      def reset(max_players)
        @board        = { 0 => Marble.new(0, 0, 0) }
        @players      = (0..max_players-1).map { |n| Player.new(n, 0) }
        @player_index = -1
        @marble_index = 0
      end

      def walk(direction, start, steps)
        m = start
        steps.times do |n|
          m = board[m.send(direction)]
        end
        m
      end


      #========== LOCATION ================================

      def next_location
        mi = marble_index + 2
        nl = (mi > board.size) ? mi - board.size : mi
      end

      def record_location(index)
        @marble_index = index
      end

      def special_location
        mi = marble_index - 7
        nl = (mi < 0) ? board.size + mi : mi
      end


      #========== PLAYER ==================================

      def next_player
        id = (player_index >= players.size - 1) ? 0 : player_index + 1
        players[id]
      end

      def record_player(player)
        @player_index = player.id
      end


      #========== STATE HELPERS ===========================

      def special?(marble)
        marble % 23 == 0
      end

    end
  end
end
