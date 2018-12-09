module Day02
  module Helpers
    Calculator = Struct.new(:boxes) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def checksum
        c2 = 0
        c3 = 0
        boxes.each do |b|
          c2 = c2 + b.two_count
          c3 = c3 + b.three_count
        end
        c2 * c3
      end

      def common_characters
        answer = nil
        copy   = boxes.map { |b| Box.new(b.id, {}) }

        boxes.each do |box1|
          copy.each do |box2|
            uc = box1.uncommon_characters(box2)
            if uc.size == 1
              answer = box1.id.gsub(uc.first, '')
              break
            end
          end
          if answer.present?
            break
          else
            copy.delete(box1)
          end
        end
        answer
      end

    end
  end
end
