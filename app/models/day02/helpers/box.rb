module Day02
  module Helpers
    class Box < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :id
      attr_accessor :two_count
      attr_accessor :three_count


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== COMPARISONS =============================

      def uncommon_characters(other)
        a1 = id.split('')
        a2 = other.id.split('')

        (0..a1.size - 1).reduce([]) do |arr, i|
          if a1[i] != a2[i]
            arr << a1[i]
          end
          arr
        end
      end


      #========== COUNTS ==================================

      def with_counts
        freqs = id.split('').tally

        self.two_count   = freqs.select { |k, v| v == 2 }.size > 0 ? 1 : 0
        self.three_count = freqs.select { |k, v| v == 3 }.size > 0 ? 1 : 0
        self
      end

    end
  end
end
