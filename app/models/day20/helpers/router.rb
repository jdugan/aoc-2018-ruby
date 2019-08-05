module Day20
  module Helpers
    Router = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def longest
        key = expression
        while i2 = key.index(')')
          ks = key.slice(0, i2).reverse
          if len = ks.index('(')
            i1 = i2 - len - 1
            ke = key.slice(i1, i2 - i1 + 1)   # whole exp including parens
            kp = ke.slice(1, ke.size - 2)
                   .split('|', -2)
                   .map { |p| p.to_s.squish }
                   .sort_by { |p| p.size }
            ko = kp.last
            key.gsub!(ke, ko)
          else
            puts '='*80
            puts 'Error: Unmatched parentheses'
            puts "key: #{ key }"
            puts "index: #{ i2 }"
            puts '='*80
            break
          end
        end
        key
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== MEMOS ===================================

      def expression
        @expression ||= begin
          s = data.first
          s.slice(1, s.size - 2)
        end
      end

    end
  end
end
