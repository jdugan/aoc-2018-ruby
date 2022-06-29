module Day03
  module Helpers
    class Pattern < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :id
      attr_accessor :x
      attr_accessor :y
      attr_accessor :w
      attr_accessor :h


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
