module Day24
  module Helpers
    Emulator = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def boost!(val)
        reset!
        army = armies.find { |a| a.name == 'Immune System' }
        army.groups.each do |g|
          g.boost = val
        end
      end

      def reset!
        @armies = nil
      end


      #========== ANSWERS =================================

      def winning_units
        n = 0
        while armies.select(&:alive?).size > 1
          # prep
          n      = n + 1
          groups = armies.flat_map(&:groups)
          groups.each(&:reset_targets!)
          groups = groups.select(&:alive?)

          # target selection phase
          ts_groups = groups.sort_by(&:targeting_choice_order)
          ts_groups.each do |tsg|
            p_groups = ts_groups.select { |g| !g.targeted? && tsg.army_id != g.army_id }
            p_groups = p_groups.sort_by { |g| g.targeting_selection_order(tsg.effective_power, tsg.attack_type) }
            p_groups = p_groups.reject  { |g| g.targeted_damage(tsg.effective_power, tsg.attack_type) == 0 }
            if targeted = p_groups.first
              tsg.targeting        = targeted
              targeted.targeted_by = tsg
            end
          end

          # attack phase
          a_groups = groups.sort_by(&:attack_order)
          a_groups.each do |ag|
            if tg = ag.targeting
              if ag.alive? && tg.alive?
                tg.take_damage!(ag.effective_power, ag.attack_type)
              end
            end
          end

          # progress
          # puts '='*80
          # puts n
          # armies.each do |a|
          #   puts a.name
          #   a.groups.each do |g|
          #     puts "#{ g.id }, #{ g.units.select(&:alive?).size }, #{ g.targeting.id rescue nil }"
          #   end
          # end
          # puts '='*80
        end

        # answer
        winner = armies.select(&:alive?).first
        winner.units.select(&:alive?).size
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== MEMOS ===================================

      def armies
        @armies ||= begin
          armies       = []
          army_id      = 0
          army         = nil
          army_regex   = Regexp.new('^(.+):$')
          group_id     = 0
          group_regex  = Regexp.new('^(\d+) units each with (\d+) hit points \(?(.*)\)?\s?with an attack that does (\d+) (\w+) damage at initiative (\d+)$')
          damage_regex = Regexp.new('^(weak|immune) to (.+)$')

          data.each do |str|
            if name = str.split(army_regex)[1]
              armies  << army  if army

              army_id  = army_id + 1
              army     = Army.new(army_id, name, [])
            else
              parts     = str.split(group_regex).slice(1..-1)
              group_id  = group_id + 1
              units     = parts[0].to_i
              hp        = parts[1].to_i
              dstr      = parts[2].to_s.strip
              ad        = parts[3].to_i
              at        = parts[4].to_s.downcase.to_sym
              init      = parts[5].to_i

              dparts    = dstr.split(';').map(&:strip)
              darray    = dparts.map { |dp| dp.split(damage_regex).slice(1..-1) }
              wa        = []
              ia        = []
              darray.each do |da|
                vals = da.last.split(', ').map { |s| s.gsub(')', '').strip.to_sym }
                if da.first == 'weak'
                  wa = vals
                else
                  ia = vals
                end
              end

              group = Group.new(group_id, army.id, ad, at, init, wa, ia, 0, [])
              group.reset_units!(units, hp)
              army.groups << group
            end
          end

          armies << army
          armies
        end
      end

    end
  end
end
