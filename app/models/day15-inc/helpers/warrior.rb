module Day15
  module Helpers
    Warrior = Struct.new(:id, :team, :strength, :health, :square) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def attack!
        if alive?
          if t = target
            t.take_damage!(strength)
          end
        end
      end

      def finalize!
        square.warrior = nil
        self[:square] = nil
      end

      def move!(shortest_paths)
        if alive?
          ids = paths.map(&:first).map(&:id).uniq
          nsq = adjacent_squares.find { |as| ids.include?(as.id) }

          nsq.warrior   = self
          self[:square] = nsq
        end
      end

      def take_damage!(amt)
        if alive?
          self[:health] = health - amt
          if dead?
            finalize!
          end
        end
      end


      #========== STATE HELPERS ===========================

      def alive?
        health > 0
      end

      def dead?
        !alive?
      end

      def has_target?
        target.present?
      end

      def same_team?(other_team)
        team == other_team
      end

      def targetable?
        alive? && adjacent_squares.any?(&:available?)
      end


      #========== UTILITY =================================

      def <=>(other)
        ss = self[:square]
        os = other.square

        [ss.y, ss.x] <=> [os.y, os.x]
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== SIBLING HELPERS =========================

      def adjacent_squares
        @adjacent_sqaures ||= begin
          keys = ['n', 'w', 'e', 's']
          sqs  = keys.map { |k| square.siblings[k] }.compact.reject(&:wall?)
          sqs
        end
      end

      def target
        adjacent_squares.map(&:warrior).compact.find { |w| !w.same_team?(team) }
      end

    end
  end
end
