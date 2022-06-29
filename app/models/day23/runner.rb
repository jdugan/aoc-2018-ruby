module Day23
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      cave.greediest_count
    end


    def p2
      cave.best_distance
    end


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
