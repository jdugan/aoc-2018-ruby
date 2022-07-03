module Day23
  class Runner < BaseRunner

    DIVISOR ||= 2.freeze
    START   ||= 2**28.freeze


    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      cave.greediest_count
    end


    def p2
      cave.best_distance
    end


    # def p2
    #   bots = raw_data.map do |line|
    #     line.scan(/-?\d+/).map(&:to_i)
    #   end
    #
    #   mult = START
    #
    #   xs = bots.map{ |b| b[0] / mult }
    #   ys = bots.map{ |b| b[1] / mult }
    #   zs = bots.map{ |b| b[2] / mult }
    #
    #   rx = xs.min..xs.max
    #   ry = ys.min..ys.max
    #   rz = zs.min..zs.max
    #
    #   loop do
    #     best = [0,0,0,0]
    #     mbots = bots.map { |bot| bot.map { |c| c / mult } }
    #
    #     rx.each do |x|
    #       ry.each do |y|
    #         rz.each do |z|
    #           c = mbots.count do |bot|
    #             ((bot[0]-x).abs + (bot[1]-y).abs + (bot[2]-z).abs) <= bot[3]
    #           end
    #           next if c < best.last
    #           next if c == best.last && (x.abs+y.abs+z.abs > best[0].abs+best[1].abs+best[2].abs)
    #           best = [x,y,z,c]
    #         end
    #       end
    #     end
    #
    #     rx = ((best[0] - 1) * DIVISOR)..((best[0] + 1) * DIVISOR)
    #     ry = ((best[1] - 1) * DIVISOR)..((best[1] + 1) * DIVISOR)
    #     rz = ((best[2] - 1) * DIVISOR)..((best[2] + 1) * DIVISOR)
    #
    #     p [mult, best]
    #
    #     (p best[0].abs+best[1].abs+best[2].abs; break) if mult == 1
    #     mult /= DIVISOR
    #   end
    # end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def cave
      @cave ||= begin
        regexp = Regexp.new('^pos=<(-?\d+),(-?\d+),(-?\d+)>,\s+r=(\d+)$')
        id     = 0

        bots = raw_data.map do |str|
          x, y, z, radius = str.split(regexp).slice(1, 4).map(&:to_i)
          id = id + 1
          Helpers::Bot.new(id: id, x: x, y: y, z: z, radius: radius)
        end

        Helpers::Cave.new(bots: bots)
      end
    end

  end
end
