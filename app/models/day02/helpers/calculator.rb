module Day02
  module Helpers
    class Calculator < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :boxes


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def checksum
        counts = boxes.reduce([0, 0]) do |arr, box|
          box = box.with_counts
          c2  = arr.first + box.two_count
          c3  = arr.last  + box.three_count
          [c2, c3]
        end
        counts.reduce(&:*)
      end

      def common_characters
        result     = nil
        last_index = boxes.size - 1

        boxes.each.with_index do |b1, i|
          (i + 1..last_index).each do |j|
            b2 = boxes[j]
            uc = b1.uncommon_characters(b2)
            if uc.size == 1
              result = b1.id.gsub(uc.first, '')
              break
            end
          end
          if result.present?
            break
          end
        end
        result
      end

    end
  end
end
