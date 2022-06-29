module Day20
  module Helpers
    class Grid

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_accessor :expression
      attr_accessor :squares

      # constructor
      def initialize(opts={})
        @expression = opts.fetch(:expression)
        @squares    = generate_squares
      end


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== SOLUTIONS ===============================
      # we use a factor of two in these methods because
      # each instruction creates both a door and a room
      #----------------------------------------------------

      def most_doors
        furthest = shortest_paths.values.sort_by(&:distance).last
        furthest.distance/2
      end

      def distant_rooms(limit)
        limit    = limit * 2
        room_ids = Set[]
        
        shortest_paths.values.each do |sp|
          if sp.distance >= limit
            far_ids = sp.path.last(sp.path.size - limit)
            room_ids.merge(far_ids)
          end
        end

        room_ids.select { |id| sq = squares[id]; sq.room? || sq.terminus? }.size
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== INITIALIZATION ==========================

      def generate_squares
        origin   = Square.new(x: 0, y: 0, type: :origin)
        sqs      = { origin.id => origin }
        sqs, ids = parse_expression(expression, sqs, [origin.id])

        termini = sqs.values.select do |sq|
          if sq.room?
            neighbors = sq.neighbor_ids.map { |nid| sqs[nid] }.compact
            neighbors.size == 1
          end
        end

        termini.each do |sq|
          sq.type    = :terminus
          sqs[sq.id] = sq
        end

        @squares = sqs
      end


      #========== PARSING HELPERS =========================

      def parse_expression(working_expression, working_squares, root_ids)
        working_ids = []

        # if more than one choice, they should be processed
        # in parallel, so we have to union the resulting
        # root ids into a superset
        choices = parse_expression_into_choices(working_expression)
        if choices.size > 1
          choices.each do |exp|
            working_squares, ids = parse_expression(exp, working_squares, root_ids)
            working_ids << ids
          end
        else
          # Else if more than one section, they should be processed
          # serially, so we keep chaining the root ids through
          # the recursion
          sections = parse_expression_into_sections(working_expression)
          if sections.size > 1
            working_ids = root_ids
            sections.each do |exp|
              working_squares, working_ids = parse_expression(exp, working_squares, working_ids)
            end

          # else, we just have a simple set of instructions
          # that can be applied to each root id.
          else
            steps = working_expression.split('')

            root_ids.each do |root_id|
              root = working_squares[root_id]

              steps.each do |direction|
                door_id = root.send("#{ direction }_id")
                unless door = working_squares[door_id]
                  door_x, door_y = door_id.split(',').map(&:to_i)
                  door           = Square.new(x: door_x, y: door_y, type: :door)
                end
                working_squares[door_id] = door

                room_id = door.send("#{ direction }_id")
                unless room = working_squares[room_id]
                  room_x, room_y = room_id.split(',').map(&:to_i)
                  room           = Square.new(x: room_x, y: room_y, type: :room)
                end
                working_squares[room_id] = room

                root = room
              end

              working_ids << root.id
            end
          end
        end

        [working_squares, working_ids.flatten.uniq]
      end

      def parse_expression_into_choices(exp)
        counter = 0
        str     = ""
        subexps = exp.split('').reduce([]) do |arr, char|
          case char
          when '('
            counter += 1
          when ')'
            counter -= 1
          when '|'
            if counter == 0
              arr << str
              str = ""
            end
          end
          unless (char == '|' && counter == 0)
            str += char
          end
          arr
        end
        subexps << str

        subexps
      end

      def parse_expression_into_sections(exp)
        counter = 0
        str     = ""
        subexps = exp.split('').reduce([]) do |arr, char|
          case char
          when '('
            counter += 1
            if counter == 1
              arr << str
              str = ""
            else
              str += char
            end
          when ')'
            counter -= 1
            if counter == 0
              arr << str
              str = ""
            else
              str += char
            end
          else
            str += char
          end
          arr
        end
        subexps << str

        subexps.reject(&:blank?)
      end


      #========== ANALYSIS HELPERS ========================

      def shortest_paths
        @shortest_paths ||= begin
          origin_id    = nil
          terminus_ids = []
          graph        = DijkstraFast::Graph.new

          squares.values.each do |s1|
            origin_id     = s1.id  if s1.origin?
            terminus_ids << s1.id  if s1.terminus?

            s1.neighbor_ids.map { |nid| squares[nid] }.compact.each do |s2|
              graph.add(s1.id, s2.id, distance: 1)
            end
          end

          terminus_ids.reduce({}) do |hash, terminus_id|
            begin
              distance, path    = graph.shortest_path(origin_id, terminus_id)
              hash[terminus_id] = OpenStruct.new({ distance: distance, path: path })
              hash
            rescue DijkstraFast::NoPathExistsError
              # ignore
            end
          end
        end
      end


      #========== PRINT HELPERS ===========================

      def print
        x_vals = squares.values.map(&:x)
        x_min  = x_vals.min - 1
        x_max  = x_vals.max + 1
        xs     = (x_min..x_max).to_a

        y_vals = squares.values.map(&:y)
        y_min  = y_vals.min - 1
        y_max  = y_vals.max + 1
        ys     = (y_min..y_max).to_a.reverse

        puts ''
        ys.each do |y|
          row = ""
          xs.each do |x|
            id = "#{ x },#{ y }"
            if sq = squares[id]
              case sq.type
              when :door
                if squares[sq.w_id] || squares[sq.e_id]
                  row += '| '
                else
                  row += '- '
                end
              when :origin
                row += '@ '
              when :terminus
                row += 'x '
              else
                row += '. '
              end
            else
              row << '# '
            end
          end
          puts row
        end
        puts ''
      end

    end
  end
end
