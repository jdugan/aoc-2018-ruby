module Day02
  module Helpers
    Box = Struct.new(:id, :checkmap) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== COUNTS ==================================

      def two_count
        if checkmap[:two].nil?
          add_counts
        end
        checkmap[:two]
      end

      def three_count
        if checkmap[:three].nil?
          add_counts
        end
        checkmap[:three]
      end


      #========== PAIRS ===================================

      def uncommon_characters(other)
        ca = []
        aa = id.split('')
        ba = other.id.split('')
        aa.each_with_index do |c, i|
          unless aa[i] == ba[i]
            ca << aa[i]
          end
          if ca.size > 1
            break
          end
        end
        ca
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      def add_counts
        checkmap[:two]   = 0
        checkmap[:three] = 0

        raw = id.split('').sort
        unq = raw.uniq

        unless raw == unq
          c2 = 0
          c3 = 0
          raw.each do |c|
            c = raw.count(c)
            case c
            when 2
              c2 = 1
            when 3
              c3 = 1
            end
            if c2 == 1 && c3 == 1
              break
            end
          end
          checkmap[:two]   = c2
          checkmap[:three] = c3
        end
      end

    end
  end
end
