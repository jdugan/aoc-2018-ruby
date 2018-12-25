module Day23
  module Helpers
    Bot = Struct.new(:id, :point, :radius) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def neighbours(bots)
        @neighbours ||= begin
          bots.reject do |b|
            point.manhattan(b.point) > radius
          end
        end
      end

    end
  end
end
