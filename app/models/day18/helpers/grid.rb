module Day18
  module Helpers
    Grid = Struct.new(:symbols, :clock, :snapshot) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def reset!
        @squares = nil
      end


      #========== ANSWERS =================================

      def value_after(iterations)
        n = 0
        iterations.times do
          next!
          register_score!(score, n)
          n = n + 1
          break if period
        end
        if p = period
          ri = (iterations - n) % p
          ri.times do
            next!
          end
        end
        score
      end


      #========== DISPLAY HELPERS =========================

      def print
        puts ""
        puts "-"*squares.first.size*2
        puts ""
        squares.each do |row|
          puts row.map(&:symbol).join
        end
        puts ""
        puts "Clock: #{ clock }"
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== ACTIONS =================================

      def next!
        snapshot!
        squares.each do |row|
          row.each do |sq|
            sq.next!(snapshot, squares)
          end
        end
        tick!
      end

      def register_score!(score, n)
        score_hash[score] ||= []
        score_hash[score] << n
      end

      def snapshot!
        self[:snapshot] = Marshal.load( Marshal.dump(squares) )
      end

      def tick!
        self[:clock] = clock + 1
      end


      #========== MEMOS ===================================

      def score_hash
        @score_hash ||= {}
      end

      def squares
        @squares ||= begin
          sqs = []
          symbols.each.with_index do |strs, y|
            strs.each.with_index do |str, x|
              sq = Square.new(x, y, str)
              sq.evaluate!

              sqs[y]    ||= []
              sqs[y][x]   = sq
            end
          end
          sqs.each do |row|
            row.each do |sq|
              sq.sum = sq.adjacent_squares(sqs).map(&:value).sum
            end
          end
          sqs
        end
      end


      #========== SCORES HELPERS ==========================

      def counts
        hash = { lumberyard: 0, open: 0, trees: 0 }
        squares.each do |row|
          row.each do |sq|
            case
            when sq.lumberyard?
              hash[:lumberyard] = hash[:lumberyard] + 1
            when sq.open?
              hash[:open] = hash[:open] + 1
            else
              hash[:trees] = hash[:trees] + 1
            end
          end
        end
        hash
      end

      def period
        p  = nil
        sh = score_hash.select { |k,v| v.size > 3 }
        sh.each do |k,v|
          vs = v.slice(-3, 3).reverse
          p1 = vs[0] - vs[1]
          p2 = vs[1] - vs[2]
          if p1 == p2
            p = p1
            break
          else
            score_hash[k] = [vs[0]]
          end
        end
        p
      end

      def score
        ch = counts
        ch[:lumberyard] * ch[:trees]
      end


      #========== STATE HELPERS ===========================



    end
  end
end
