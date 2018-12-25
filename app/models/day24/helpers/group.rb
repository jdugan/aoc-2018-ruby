module Day24
  module Helpers
    Group = Struct.new(:id, :army_id, :attack_damage, :attack_type, :initiative, :weaknesses, :immunities, :boost, :units) do

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :targeted_by
      attr_accessor :targeting


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------


      #========== ACTIONS =================================

      def print!
        puts "#{ id }, #{ targeting_choice_order }"
      end

      def reset_targets!
        @targeting   = nil
        @targeted_by = nil
      end

      def reset_units!(num, hit_points)
        num.times do |i|
          self[:units] << Unit.new(i+1, hit_points)
        end
      end

      def take_damage!(base_damage, attack_type)
        amount = targeted_damage(base_damage, attack_type)
        living = units.select(&:alive?)
        # puts "#{ id }, #{ units.size }, #{ attack_type }, #{ base_damage }, #{ amount }, #{ living.first.hit_points }"
        unless living.empty?
          num     = amount / living.first.hit_points
          targets = living.first(num)
          targets.each do |t|
            t.hit_points = 0
          end
        end
      end


      #========== COMPARATORS =============================

      def attack_order
        [-initiative]
      end

      def targeting_choice_order
        [-effective_power, -initiative]
      end

      def targeting_selection_order(base_damage, attack_type)
        [-targeted_damage(base_damage, attack_type), -effective_power, -initiative]
      end


      #========== GETTERS =================================

      def effective_power
        units.select(&:alive?).size * strength
      end

      def strength
        attack_damage + boost
      end

      def targeted_damage(base_damage, attack_type)
        factor =
          case
          when weaknesses.include?(attack_type)
            2
          when immunities.include?(attack_type)
            0
          else
            1
          end

        base_damage * factor
      end


      #========== SETTERS =================================

      def targeted_by=(group)
        @targeted_by = group
      end

      def targeting=(group)
        @targeting = group
      end


      #========== STATE HELPERS ===========================

      def alive?
        Array(units).any?(&:alive?)
      end

      def dead?
        !alive?
      end

      def targeted?
        @targeted_by.present?
      end

      def targeting?
        @targeting.present?
      end

    end
  end
end
