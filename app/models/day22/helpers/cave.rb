module Day22
  module Helpers
    class Cave < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_accessor :depth
      attr_accessor :target_coords


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def risk_level
        (0..target_coords.last).to_a.reduce(0) do |sum, y|
          (0..target_coords.first).to_a.each do |x|
            sum = sum + squares["#{ x },#{ y }"].risk_level
          end
          sum
        end
      end

      def shortest_time
        mouth_id  = "0,0,torch"
        target_id = "#{ target_coords.join(',') },torch"

        distance, _ = graph.shortest_path(mouth_id, target_id)
        distance
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== ACTIONS =================================

      def print
        xs = 0..squares.values.map(&:x).max
        ys = 0..squares.values.map(&:y).max

        puts ''
        ys.each do |y|
          row = ""
          xs.each do |x|
            row += squares["#{ x },#{ y }"].print
          end
          puts row
        end
        puts ''
      end


      #========== MEMOS ===================================

      def graph
        @graph ||= begin
          valid_tools = {
            rocky:  [:climbing, :torch],
            wet:    [:climbing, :none],
            narrow: [:torch, :none]
          }

          g = DijkstraFast::Graph.new
          squares.values.each do |sq0|
            vt0  = valid_tools[sq0.geologic_type]

            # add switching nodes for this location
            vid1 = "#{ sq0.id },#{ vt0.first }"
            vid2 = "#{ sq0.id },#{ vt0.last }"
            g.add(vid1, vid2, distance: 7)
            g.add(vid2, vid1, distance: 7)

            # add movement nodes where tooling allows
            neighbors = sq0.neighbor_ids.map { |id| squares[id] }.compact
            neighbors.each do |sq1|
              vt1 = valid_tools[sq1.geologic_type]
              vts = vt0.intersection(vt1)
              vts.each do |tool|
                g.add("#{ sq0.id },#{ tool }", "#{ sq1.id },#{ tool }", distance: 1)
              end
            end
          end

          g
        end
      end

      def squares
        @squares ||= begin
          tx = target_coords.first
          ty = target_coords.last
          mx = tx + 50
          my = ty + 50

          # basic fill; set location types
          sqs = Array.new(my+1).fill { Array.new(mx+1) }
          (0..my).to_a.each do |y|
            (0..mx).to_a.each do |x|
              sqs[y][x] = Square.new(x, y, depth, :normal)
            end
          end
          sqs[0][0].mouth!
          sqs[ty][tx].target!

          # set geologic indices
          sqh = {}
          sqs.each.with_index do |row, y|
            row.each.with_index do |sq, x|
              sq.geologic_index =
                case
                when sq.mouth? || sq.target?
                  0
                when sq.x == 0
                  sq.y * 48271
                when sq.y == 0
                  sq.x * 16807
                else
                  xe = sqs[sq.y][sq.x-1].erosion_level
                  ye = sqs[sq.y-1][sq.x].erosion_level
                  xe * ye
                end

              sqh[sq.id] = sq
            end
          end

          # return hash
          sqh
        end
      end

    end
  end
end
