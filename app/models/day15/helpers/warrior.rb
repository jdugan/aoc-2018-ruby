module Day15
  module Helpers
    Warrior = Struct.new(:id, :team, :strength, :health, :square) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def attack!
        if alive?
          if o = opponent
            o.take_damage!(strength)
          end
        end
      end

      def finalize!
        square.warrior = nil
        self[:square] = nil
      end

      def relocate!(new_square)
        square.warrior = nil
        new_square.warrior = self
        self[:square] = new_square
      end

      def take_damage!(amt)
        if alive?
          self[:health] = health - amt
          if dead?
            finalize!
          end
        end
      end


      #========== GRAPH HELPERS ===========================

      def calculate_step(destination_ids)
				nodes  = weighted_nodes
				dist   = Float::INFINITY
        sid    = square.id
        paths  = destination_ids.map do |did|
          helper = dijkstra_helper(sid, did, nodes)
	        path   = helper.path
					if path.present?
            dist = [path.size, dist].min
						puts path.inspect	if id == 4
            [did, sid, path[1], path.size]
          else
            nil
          end
        end.compact

        shortests = paths.select { |p| p.last == dist }

				if id == 4
          puts '='*80
					puts id
					puts '-'*80
					puts nodes.inspect
          puts '-'*80
          puts paths.sort_by(&:last).inspect
          puts '-'*80
          puts shortests.inspect
          puts '='*80
        end

        shortests.map { |s| s[1] }
                 .sort_by { |s| s.split('|').map(&:to_i).reverse }
                 .first   # reading order breaks ties
      end


      #========== SIBLING HELPERS =========================

      def opponent
        warriors = square.occupied_neighbors.map(&:warrior).compact
        warriors.select { |w| enemy?(w) }
                .sort_by { |w| [w.health, w.square.reading_index] }
                .first
      end

      def targetable_squares
        square.available_neighbors
      end


      #========== STATE HELPERS ===========================

      def alive?
        health > 0
      end

      def dead?
        !alive?
      end

      def enemy?(other)
        team != other.team
      end

      def friend?(other)
        team == other.team
      end

      def has_opponent?
        opponent.present?
      end

      def targetable?
        alive? && square.available_neighbors.present?
      end


      #========== UTILITY =================================

      def <=>(other)
        ss = self[:square]
        os = other.square

        ss.reading_index <=> os.reading_index
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== GRAPH HELPERS ===========================

			def weighted_nodes
				nodes = {}
        sources = [square]
        while sources.present?
          tmp = []
          sources.each do |s|
            dest_hash = s.available_neighbors.reduce({}) do |hash, d|
							tmp << d 	unless nodes.has_key?(d.id)		# if untracked, add to future sources
              hash[d.id] = 1
							hash
            end
						nodes[s.id] = dest_hash
          end
          sources = tmp.flatten.uniq
        end
				# puts '='*80
				# puts nodes.keys.sort.inspect
				# puts '='*80
				# throw StandardError('quit')
        nodes
			end

			def dijkstra_helper(src, dest, nodes)
				finder = ShortestPath::Finder.new(src, dest).tap do |finder|
  				finder.ways_finder = Proc.new { |id| nodes[id] }
				end
			end

      # def current_graph
      #   graph   = DijkstraGraph::Graph.new
      #   added   = []
      #   sources = [square]
      #   while sources.present?
      #     tmp = []
      #     sources.each do |s|
      #       dests = s.available_neighbors.reject do |d|
      #         added.include?([s.id, d.id])
      #       end.reverse
      #       dests.each do |d|
      #         graph.add_edge(s.id, d.id, 1)
      #         added << [s.id, d.id]
      #       end
      #       tmp << dests
      #     end
      #     sources = tmp.flatten.uniq
      #   end
      #   graph
      # end

    end
  end
end
