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
        # print
        iterations.times do |n|
          next!
          # print
          puts "#{ clock }: #{ score }"
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

      def snapshot!
        self[:snapshot] = Marshal.load( Marshal.dump(squares) )
      end

      def tick!
        self[:clock] = clock + 1
      end


      #========== HELPERS =================================

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

      def score
        ch = counts
        ch[:lumberyard] * ch[:trees]
      end


      #========== MEMOS ===================================

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

    end
  end
end
