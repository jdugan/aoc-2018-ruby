module Day10
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      sky.message
    end


    def p2
      sky.time
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def sky
      @sky ||= begin
        points = raw_data.map do |str|
          pattern      = Regexp.new('^position=<(-?\s?\d*), (-?\s?\d*)> velocity=<(-?\s?\d*), (-?\s?\d*)>$')
          x, y, vx, vy = str.split(pattern).reject(&:blank?).map(&:to_i)

          Helpers::Point.new(x: x, y: y, vx: vx, vy: vy)
        end

        Helpers::Sky.new(points: points, clock: 0)
      end
    end

  end
end
