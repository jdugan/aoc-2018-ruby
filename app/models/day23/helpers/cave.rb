module Day23
  module Helpers
    class Cave < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_accessor :bots


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def best_distance
        best_location.manhattan_to_origin
      end

      def greediest_count
        greediest_bot.neighbours(bots).size
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== CALCULATIONS ============================

      def best_location
        origin       = Bot.new(x: 0, y: 0, z: 0, radius: 1)
        default_best = OpenStruct.new({ bot: origin, count: 0 })

        rx = [0]
        ry = [0]
        rz = [0]

        factor   = 2
        offset   = 2
        multiple = factor**32

        while multiple > 0
          best   = default_best
          sbots  = bots.map { |b| b.shrink(multiple) }

          rx.each do |x|
            ry.each do |y|
              rz.each do |z|
                ref = Bot.new(x: x, y: y, z: z, radius: 1)
                cnt = sbots.count { |sb| sb.manhattan(ref) <= sb.radius }

                case
                when cnt < best.count
                  next
                when cnt == best.count && ref.manhattan_to_origin > best.bot.manhattan_to_origin
                  next
                else
                  bbot = Bot.new(x: x, y: y, z: z, radius: 1)
                  best = OpenStruct.new({ bot: bbot, count: cnt })
                end
              end
            end
          end

          x, y, z = best.bot.coords
          rx = ((x - offset) * factor)..((x + offset) * factor)
          ry = ((y - offset) * factor)..((y + offset) * factor)
          rz = ((z - offset) * factor)..((z + offset) * factor)

          multiple = multiple / factor
        end

        best.bot
      end


      #========== MEMOS ===================================

      def best_bots
        @best_bots ||= begin
          bots.map do |b|
            [b.point, b.radius, b.neighbours(bots).size]
          end
        end
      end

      def greediest_bot
        @greediest_bot ||= begin
          bots.sort_by(&:radius).last
        end
      end

    end
  end
end
