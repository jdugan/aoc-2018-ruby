module Day17
  module Helpers
    Grid = Struct.new(:data) do

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      SPRING_X   ||= 500
      SPRING_Y   ||= 0
      SPRING_KEY ||= "#{ SPRING_X }|#{ SPRING_Y }"


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def flow!
        unless water_count > 0
          max_steps = 5000
          step  = 0
          cells = [spring]
          while cells.size > 0 && step < max_steps
            edges   = []
            cells.each do |cell|
              if cell.y + 1 <= y_max
                if open?(cell, :south) || passable?(cell, :south)
                  edges << move_south(cell)
                else
                  west_edge = move_west_recursively(cell)
                  east_edge = move_east_recursively(cell)

                  lateral_edges = [west_edge, east_edge].compact

                  if lateral_edges.empty?
                    edges << move_north(cell)
                  else
                    edges = edges + lateral_edges
                  end
                end
              end
            end
            step = step + 1
            cells = edges.compact.uniq
          end
        end
      end


      #========== AGGREGATES ==============================

      def standing_count
        registry.values
                .select { |c| c.standing? && c.y >= y_min && c.y <= y_max }
                .size
      end

      def water_count
        registry.values
                .select { |c| c.water? && c.y >= y_min && c.y <= y_max }
                .size
      end


      #========= COORDS ===================================

      def spring
        @spring ||= registry[SPRING_KEY]
      end

      def x_max
        @x_max ||= limits[:x].to_a.max + 1
      end

      def x_min
        @x_min ||= limits[:x].to_a.min - 1
      end

      def y_max
        @y_max ||= limits[:y].to_a.max
      end

      def y_min
        @y_min ||= limits[:y].to_a.min
      end


      #========== VISUALISATION ===========================

      def print
        xs = (x_min..x_max).to_a
        ys = (0..y_max).to_a

        puts ''
        ys.each do |y|
          a = []
          xs.each do |x|
            k = "#{ x }|#{ y }"
            v = registry.key?(k) ? registry[k].to_s : '.'
            a << v
          end
          puts a.join(' ')
        end
        puts ''
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== FLOW: LOOP HELPERS ======================

      def find_barrier(cell, direction)
        rc = cell
        while rc.present? && rc.water?
          dkey = rc.send("#{ direction }_key")
          rc   = registry[dkey]
        end
        bc = rc && rc.barrier? ? rc : nil
      end

      def move_east_recursively(cell)
        skey = cell.source_key
        step = 0
        while step != -1
          rc = registry["#{ cell.x + step }|#{ cell.y }"]
          wc = move_east(rc, skey)
          if wc
            if open?(wc, :south) || passable?(wc, :south)
              edge = wc
              step = -1
            else
              step = step + 1
            end
          else
            edge = nil
            step = -1
          end
        end
        edge
      end

      def move_west_recursively(cell)
        skey = cell.source_key
        step = 0
        while step != -1
          rc = registry["#{ cell.x - step }|#{ cell.y }"]
          wc = move_west(rc, skey)
          if wc
            if open?(wc, :south) || passable?(wc, :south)
              edge = wc
              step = -1
            else
              skey = wc.source_key
              step = step + 1
            end
          else
            edge = nil
            step = -1
          end
        end
        edge
      end


      #========== FLOW: MOVE HELPERS ======================

      def move_east(current, source_key = nil)
        key = current.east_key
        if cell = registry[key]
          cell = nil  unless cell.passable?
        else
          skey = source_key || current.source_key
          cell = registry[key] = Cell.new(key, skey, :running)
        end
        cell
      end

      def move_north(cell)
        stand!(cell)
        registry[cell.source_key]
      end

      def move_south(current, source_key = nil)
        key = current.south_key
        if registry[key]
          cell = nil
        else
          skey = source_key || current.key
          cell = registry[key] = Cell.new(key, skey, :running)
        end
        cell
      end

      def move_west(current, source_key = nil)
        key = current.west_key
        if cell = registry[key]
          cell = nil  unless cell.passable?
        else
          skey = source_key || current.source_key
          cell = registry[key] = Cell.new(key, skey, :running)
        end
        cell
      end

      #========== FLOW: STATE HELPERS =====================

      def stand!(cell)
        ec = find_barrier(cell, :east)
        wc = find_barrier(cell, :west)

        if ec && wc
          wk = wc.east_key
          ek = ec.west_key

          x1 = registry[wk].x
          x2 = registry[ek].x
          y  = registry[wk].y

          (x1..x2).each do |x|
            key = "#{ x }|#{ y }"
            rc  = registry[key]
            registry[rc.key] = Cell.new(rc.key, rc.source_key, :standing)
          end
        end
      end

      def open?(cell, direction)
        key = cell.send("#{ direction }_key")
        !registry[key]
      end

      def passable?(cell, direction)
        key = cell.send("#{ direction }_key")
        rc  = registry[key]
        rc && rc.passable?
      end


      #========== MEMOS ===================================

      def registry
        @registry ||= begin
          regex = Regexp.new('^(x|y)=(\d+), (x|y)=(\d+)..(\d+)$')

          rh = data.reduce({}) do |hash, str|
            dt1, dv1, dt2, dv2s, dv2f = str.strip.split(regex).slice(1, 5)
            if dt1 == 'x'
              xs = [dv1]
              ys = (dv2s..dv2f).to_a
            else
              ys = [dv1]
              xs = (dv2s..dv2f).to_a
            end

            xs.product(ys).each do |x, y|
              key = "#{ x }|#{ y }"
              hash[key] = Cell.new(key, nil, :clay)
            end
            hash
          end

          rh[SPRING_KEY] = Cell.new(SPRING_KEY, nil, :spring)   # add the spring
          rh
        end
      end

      def limits
        @limits ||= begin
          xkeys, ykeys = registry.keys.reject { |k| k == SPRING_KEY }
                                      .map{ |k| k.split('|').map(&:to_i) }
                                      .transpose

          { x: (xkeys.min-1..xkeys.max+1), y: (ykeys.min..ykeys.max) }
        end
      end

    end
  end
end
