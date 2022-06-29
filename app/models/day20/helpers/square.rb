module Day20
  module Helpers
    class Square

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_accessor :x
      attr_accessor :y
      attr_accessor :type

      # constructor
      def initialize(opts={})
        @x    = opts.fetch(:x)
        @y    = opts.fetch(:y)
        @type = opts.fetch(:type)
      end


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ATTRIBUTES ==============================

      def id
        "#{ x },#{ y }"
      end

      def e_id
        "#{ x + 1 },#{ y }"
      end

      def n_id
        "#{ x },#{ y + 1}"
      end

      def s_id
        "#{ x },#{ y - 1}"
      end

      def w_id
        "#{ x - 1 },#{ y }"
      end


      #========== ADJACENCY HELPERS =======================

      def neighbor_ids
        [n_id, e_id, s_id, w_id]
      end


      #========== TYPE HELPERS ============================

      [:origin, :door, :room, :terminus].each do |t|
        define_method "#{ t }?" do
          type == t
        end
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

    end
  end
end
