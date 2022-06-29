module Day06
  module Helpers
    class Grid < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :points


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ATTRIBUTES ==============================

      def coords
        @coords ||= begin
          xs = (0..width).to_a
          ys = (0..height).to_a
          xs.product(ys)
        end
      end

      def corner_keys
        [
          "0|0",
          "0|#{ height }",
          "#{ width }|0",
          "#{ width }|#{ height }"
        ]
      end

      def height
        @height ||= begin
          points.map(&:y).max
        end
      end

      def width
        @width ||= begin
          points.map(&:x).max
        end
      end


      #========== HELPERS =================================

      def analysis
        @analysis ||= begin
          coords.reduce({}) do |hash, gc|
            gp     = Point.new(coords: gc)
            danger = {}
            safe   = 0

            points.each do |p|
              # common
              id   = p.id
              dist = gp.distance(p)

              # danger
              case
              when danger.empty?
                danger = { id: id, distance: dist, tied: false }
              when dist < danger[:distance]
                danger = { id: id, distance: dist, tied: false }
              when dist == danger[:distance]
                danger = { id: id, distance: dist, tied: true }
              end

              # safe
              safe = safe + dist
            end

            hash[gp.key] = { danger: danger, safe: safe }
            hash
          end
        end
      end

    end
  end
end
