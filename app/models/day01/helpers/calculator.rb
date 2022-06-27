module Day01
  module Helpers
    class Calculator < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :deltas


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def first_duplicate
        freq_set = Set.new([0])
        freq     = 0
        found    = false

        while !found do
          deltas.each do |df|
            freq = freq + df
            if freq_set.include?(freq)
              found = true
              break
            end
            freq_set = freq_set.add(freq)
          end
        end

        freq
      end

      def sum
        deltas.sum
      end

    end
  end
end
