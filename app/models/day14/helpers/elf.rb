module Day14
  module Helpers
    Elf = Struct.new(:id, :recipe) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      #========== ACTIONS =================================

      def walk!(direction, steps)
        nr = recipe
        steps.times do
          nr = nr.send(direction)
        end
        self[:recipe] = nr
      end


      #========== ATTRIBUTES ==============================
      
      def score
        recipe.score
      end

    end
  end
end
