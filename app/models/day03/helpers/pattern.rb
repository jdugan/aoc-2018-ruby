module Day03
  module Helpers
    Pattern = Struct.new(:id, :x, :y, :w, :h) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def keys
        xs = (x..x+w-1).to_a
        ys = (y..y+h-1).to_a
        xs.product(ys).map { |(a,b)| "#{ a }|#{ b }" }
      end

    end
  end
end
