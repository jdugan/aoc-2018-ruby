module Day01
  module Helpers
    Calculator = Struct.new(:data) do

      #------------------------------------------------------
      # Public Methods
      #------------------------------------------------------

      def first_duplicate
        fmap = { 0 => true }
        freq = 0
        dupl = nil

        while dupl.nil? do                  # the list must be looped many times
          frequencies.each do |fc|          # to find a duplicate frequency.
            nf = freq + fc
            if fmap.has_key?(nf)
              dupl = nf
              break
            else
              fmap[nf] = true
              freq     = nf
            end
          end
        end
        dupl
      end

      def sum
        frequencies.sum
      end


      #------------------------------------------------------
      # Public Methods
      #------------------------------------------------------
      private

      def frequencies
        @frequencies ||= Array(data).map(&:to_i)
      end

    end
  end
end
