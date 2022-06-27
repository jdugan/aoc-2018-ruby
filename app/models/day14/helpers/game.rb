module Day14
  module Helpers
    Game = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def last_ten
        reset!
        while recipes.size < target_size + 10
          turn!
        end
        run_after(recipes[target_size], 10)
      end

      def recipes_before_run
        reset!
        n = 0
        while last_run != target_run
          turn!(true)
          n = n + 1
          # puts "#{ n }: #{ last_run }" if n % 1000000 == 0
        end
        last_recipe.id - target_run.size
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== ACTIONS =================================

      def add_recipe!(score)
        fr  = first_recipe
        lr  = last_recipe
        id  = lr.id + 1

        nr = Recipe.new(id, score, lr, fr)
        recipes[id] = nr

        fr.left  = nr
        lr.right = nr
        nr
      end

      def reset!
        @last_run = nil
        @recipes  = nil
        elves.each_with_index do |elf, index|
          elf.recipe = recipes[index]
        end
      end

      def turn!(update_run=false)
        new_scores.each do |s|
          nr = add_recipe!(s)
          if update_run
            @last_run = (last_run + nr.score.to_s).last(target_run.size)
            if last_run == target_run
              update_run = false
            end
          end
        end
        elves.each do |e|
          e.walk!(:right, e.score + 1)
        end
      end


      #========== HELPERS =================================

      def first_recipe
        recipes[0]
      end

      def last_recipe
        first_recipe.left
      end

      def new_scores
        elves.map(&:score).sum.to_s.split('').map(&:to_i)
      end

      def run_after(recipe, size)
        fs = recipe.score.to_s
        (size - 1).times do
          recipe = recipe.right
          fs << recipe.score.to_s
        end
        fs
      end


      #========== MEMOS ===================================

      def elves
        @elves ||= begin
          es = []
          2.times { |n| es << Elf.new(n, recipes[n]) }
          es
        end
      end

      def recipes
        @recipes ||= begin
          r0 = Recipe.new(0, 3, 'dummy', 'dummy')
          r1 = Recipe.new(1, 7, r0, r0)
          r0.left  = r1
          r0.right = r1

          { 0 => r0, 1 => r1 }
        end
      end

      def last_run
        @last_run ||= begin
          a = recipes.values.last(target_run.size)
          a.map(&:score).join
        end
      end

      def target_run
        @target_run ||= data.last.to_i.to_s
      end

      def target_size
        @target_size ||= data.first.to_i
      end

    end
  end
end
