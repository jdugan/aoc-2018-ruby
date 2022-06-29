module Day15
  module Helpers
    class Warrior

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_accessor :id
      attr_accessor :team
      attr_accessor :strength
      attr_accessor :health
      attr_accessor :square

      # constructor
      def initialize(opts={})
        @id       = opts.fetch(:id)
        @team     = opts.fetch(:team)
        @strength = opts.fetch(:strength, 3)
        @health   = opts.fetch(:health, 200)
        @square   = opts[:square]
      end


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def attack!
        if alive?
          if o = opponent
            o.take_damage!(strength)
          end
        end
      end

      def finalize!
        square.warrior = nil
        self.square = nil
      end

      def relocate!(new_square)
        square.warrior = nil
        new_square.warrior = self
        self.square = new_square
      end

      def take_damage!(amt)
        if alive?
          self.health = health - amt
          if dead?
            finalize!
          end
        end
      end


      #========== SIBLING HELPERS =========================

      def opponent
        warriors = square.occupied_neighbors.map(&:warrior).compact
        warriors.select { |w| enemy?(w) }
                .sort_by { |w| [w.health, w.square.reading_index] }
                .first
      end

      def targetable_squares
        square.available_neighbors
      end


      #========== STATE HELPERS ===========================

      def alive?
        health > 0
      end

      def dead?
        !alive?
      end

      def elf?
        team == 'E'
      end

      def enemy?(other)
        team != other.team
      end

      def friend?(other)
        team == other.team
      end

      def goblin?
        team == 'G'
      end

      def has_opponent?
        opponent.present?
      end

      def targetable?
        alive? && square.available_neighbors.present?
      end


      #========== UTILITY =================================

      def <=>(other)
        ss = self.square
        os = other.square

        ss.reading_index <=> os.reading_index
      end

    end
  end
end
