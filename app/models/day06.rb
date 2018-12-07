class Day06 < AbstractDay

  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  def p1
    # manhattan.danger_visualization
    manhattan.danger_area
  end


  def p2
    # manhattan.safe_visualization
    manhattan.safe_area
  end


  #--------------------------------------------------------
  # Private Methods
  #--------------------------------------------------------
  private

  def manhattan
    @manhattan ||= Manhattan.new(points: points)
  end

  def points
    @points ||= begin
      i = -1
      data.reduce({}) do |hash, s|
        i = i + 1
        c = s.split(',').map(&:to_i)
        hash[i] = c
        hash
      end
    end
  end



  #--------------------------------------------------------
  # Inner Classes
  #--------------------------------------------------------

  class Manhattan

    #========== CONFIGURATION =============================

    SAFE_LIMIT = 10000

    attr_reader :points

    def initialize(hash)
      @points = hash[:points]
    end


    #========== PUBLIC METHODS ============================

    #---------- danger methods ----------------------------

    def danger_area
      danger_area_map.values.sort.last
    end

    def danger_visualization
      puts ''
      danger_visual_map.each do |ya|
        puts ya.join(' ')
      end
      puts ''
    end


    #---------- safe methods ------------------------------

    def safe_area
      distance_map.values.select { |v| v[:safe] < SAFE_LIMIT }.size
    end

    def safe_visualization
      puts ''
      safe_visual_map.each do |ya|
        puts ya.join(' ')
      end
      puts ''
    end


    #========== PRIVATE METHODS ===========================
    private

    def distance_map
      @distance_map ||= begin
        kart = {}
        grid_coords.each do |gc|
          key  = "#{ gc.first }|#{ gc.last }"
          curr = kart[key] || { danger: [], safe: 0 }
          cda  = curr[:danger]
          csd  = curr[:safe]

          points.each_pair do |(id, pc)|
            # common
            d = distance(gc, pc)

            # danger
            if cda.empty?
              cda = [id, d, false]
            else
              od = cda[1]
              case
              when d < od
                cda = [id, d, false]
              when d == od
                cda = [id, d, true]
              end
            end

            # safe
            if csd < SAFE_LIMIT
              csd = csd + d
            end
          end

          kart[key] = { danger: cda, safe: csd }
        end
        kart
      end
    end


    #---------- danger maps -------------------------------

    def danger_area_map
      @danger_area_map ||= begin
        keys  = [ "0|0", "0|#{ grid_height }", "#{ grid_width }|0", "#{ grid_width }|#{ grid_height }" ]
        ids   = keys.map { |k| distance_map[k][:danger].first }
        kart = distance_map.reduce({}) do |hash, (k, v)|
          arr  = v[:danger]
          id   = arr.first

          unless ids.include?(id)
            unless arr.last  # i.e, tied
              hash[id] ||= 0
              hash[id]   = hash[id] + 1
            end
          end
          hash
        end
        kart
      end
    end

    def danger_visual_map
      @danger_visual_map ||= begin
        letters = ('a'..'z').to_a
        kart = Array.new(grid_height + 1) { Array.new(grid_width + 1) }
        distance_map.each_pair do |k, v|
          cs   = k.split('|').map(&:to_i)
          x    = cs.first
          y    = cs.last
          a    = v[:danger]
          tied = a.last

          display = (tied) ? '.' : letters[a.first % 26]
          display = display.upcase if a[1] == 0

          kart[y][x] = display
        end
        kart
      end
    end


    #---------- safe maps ---------------------------------

    def safe_visual_map
      @safe_visual_map ||= begin
        letters = ('a'..'z').to_a
        kart = Array.new(grid_height + 1) { Array.new(grid_width + 1) }
        distance_map.each_pair do |k, v|
          cs   = k.split('|').map(&:to_i)
          x    = cs.first
          y    = cs.last
          d    = v[:safe]

          display = (d < SAFE_LIMIT) ? '#' : '.'

          kart[y][x] = display
        end
        kart
      end
    end


    #---------- other helpers -----------------------------

    def distance(c1, c2)
      ax = (c1.first - c2.first).abs
      ay = (c1.last - c2.last).abs
      ax + ay
    end

    def grid_coords
      @grid_coords ||= begin
        xs = (0..grid_width).to_a
        ys = (0..grid_height).to_a
        xs.product(ys)
      end
    end

    def grid_height
      @grid_height ||= points.values.map(&:last).sort.last
    end

    def grid_width
      @grid_width ||= points.values.map(&:first).sort.last
    end

  end

end
